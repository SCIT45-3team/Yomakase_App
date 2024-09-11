import UIKit

class FloatingLabelTextField: UITextField {

    // MARK: - Properties

    private let floatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let floatingLabelHeight: CGFloat = 20.0
    private let textInsets = UIEdgeInsets(top: 24, left: 5, bottom: 8, right: 0) // 상하 여백을 늘림
    
    // MARK: - Custom Properties

    var floatingLabelText: String? {
        didSet {
            floatingLabel.text = floatingLabelText
            updateFloatingLabel()
        }
    }
    
    // MARK: - Lifecycle

    override var text: String? {
        didSet {
            updateFloatingLabel()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupFloatingLabel()
        updateFloatingLabel()
    }
    
    // MARK: - Setup

    private func setupFloatingLabel() {
        if floatingLabel.superview == nil {
            addSubview(floatingLabel)
            floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                floatingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                floatingLabel.heightAnchor.constraint(equalToConstant: floatingLabelHeight)
            ])
        }
    }

    private func updateFloatingLabel() {
        let isTextEmpty = text?.isEmpty ?? true
        let isTextFieldFirstResponder = isFirstResponder
        
        UIView.animate(withDuration: 0.3) {
            if isTextEmpty && !isTextFieldFirstResponder {
                self.floatingLabel.transform = .identity
                self.floatingLabel.textColor = .systemGray
            } else {
                self.floatingLabel.transform = CGAffineTransform(translationX: 0, y: -self.floatingLabelHeight / 2).scaledBy(x: 0.8, y: 0.8)
                self.floatingLabel.textColor = .systemBlue
            }
        }
    }
    
    // MARK: - Overrides

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
}
