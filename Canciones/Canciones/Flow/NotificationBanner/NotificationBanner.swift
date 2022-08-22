//
//  NotificationBanner.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import SwiftUI

struct _NotificationBanner: View {
    @Binding var isPresented: Bool
    let configuration: NotificationBannerConfiguration
    var body: some View {
        Group {
            if isPresented {
                ZStack {
                    Color.red
                        .cornerRadius(20)
                    HStack {
                        VStack(alignment:.leading) {
                            Text(configuration.title)
                                .lineLimit(1)
                                .foregroundColor(.white)
                                .font(.headline)
                            Text(configuration.subtitle)
                                .foregroundColor(.white)
                                .font(.callout)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                .frame(maxWidth: .infinity, maxHeight: 88)
                .padding()
            } else {
                EmptyView()
            }
        }
        .onTapGesture {
            isPresented = false
        }
        .animation(.default, value: isPresented)
    }
}

struct NotificationBanner_Previews: PreviewProvider {
    static var previews: some View {
        _NotificationBanner(isPresented: .constant(true), configuration: NotificationBannerConfiguration.dummy)
    }
}

struct NotificationBanner: ViewModifier {
    let configuration: NotificationBannerConfiguration
    @Binding var isPresented: Bool
    func body(content: Content) -> some View {
        content.overlay(alignment:.top) {
            _NotificationBanner(isPresented: $isPresented, configuration: configuration)
        }
    }
}

extension View {
    func notificationBanner(isPresented: Binding<Bool>, configuration: NotificationBannerConfiguration) -> some View {
        modifier(NotificationBanner(configuration: configuration, isPresented: isPresented))
    }
}
