import UIKit

public struct JobApplicant {
    public enum Status {
        case new
        case interview
        case hired
        case rejected
    }
    public let name: String
    public let email: String
    public var status: Status
}

// Email subject and message body will be different depending on an applicant status
public struct Email {
    public let subject: String
    public let messageBody: String
    public let recipientEmail: String
    public let senderEmail: String
}

// factory method for create emails
public struct EmailFactory {
    public let senderEmail: String
    
    public func createEmail(to recipient: JobApplicant) -> Email {
        let subject: String
        let messageBody: String
        switch recipient.status {
        case .new:
            subject = "We received your application"
            messageBody = "Thanks for applying for a job here"
        case .interview:
            subject = "We want to interview you"
            messageBody = "Thanks for sending us your resume"
        case.hired:
            subject = "We want to hired you!"
            messageBody = "We would like to make you and offer $$"
        case .rejected:
            subject = "Thanks for your application"
            messageBody = "We decided to move forward with other candidates"
        }
        return Email(subject: subject, messageBody: messageBody, recipientEmail: recipient.email, senderEmail: senderEmail)

    }
}

//Example
var applicant = JobApplicant(name: "juancho", email: "juancho.com", status: .interview)
let emailFactory = EmailFactory(senderEmail: "yournextjob.com")
print(emailFactory.createEmail(to: applicant), "\n")

applicant.status = .rejected
print(emailFactory.createEmail(to: applicant), "\n")

applicant.status = .hired
print(emailFactory.createEmail(to: applicant), "\n")

