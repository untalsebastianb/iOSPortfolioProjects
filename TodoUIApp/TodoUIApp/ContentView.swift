//
//  ContentView.swift
//  TodoUIApp
//
//  Created by Juan Sebastian Bueno on 10/27/23.
//

import SwiftUI

struct ContentView: View {
    @State var inventories: [InventoryModel] = []
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                headerBackground
                Spacer()
            }
            navBarCustom
            
            VStack {
                Spacer()
                    .frame(height: 50)
                cardStatus
                sectionTitle
                List(inventories) { inventory in
                    CardView(inventory: inventory)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            inventories = InventoryModel.getInventory()
        }
    }

    
    var sectionTitle: some View {
        HStack {
            Text("Due today")
            Spacer()
            HStack {
                Text("Sort by")
                Button { 
                    print("button pressed")
                } label: { 
                    Image(systemName: "slider.vertical.3")
                }

            }
            
        }
        .padding(.top, 20)
        .padding(.horizontal, 30)
        .foregroundColor(Color.black.opacity(0.6))
    }
    
    var cardStatus: some View {
        HStack(spacing: 30) {
            VStack(spacing: 5) {
                Text("421")
                    .font(.system(size: 25, weight: .bold))
                Text("overdue")
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)                        
            }
            VStack(spacing: 5) {
                Text("81")
                    .font(.system(size: 25, weight: .bold))
                Text("to do")
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)                        
            }
            VStack(spacing: 5) {
                Text("72")
                    .font(.system(size: 25, weight: .bold))
                Text("open")
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)                        
            }
            VStack(spacing: 5) {
                Text("51")
                    .font(.system(size: 25, weight: .bold))
                Text("due today")
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)                        
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        .background(Color.white)
        .cornerRadius(20.0)
        .shadow(color: Color.gray.opacity(0.3), radius: 14, x: 0, y: 0)
        .padding(.horizontal, 20)
    }
    
    var navBarCustom: some View {
        VStack {
            HStack {
                // Hamburguer button                    
                Button { 
                    print("-")
                } label: { 
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 25, weight: .bold))
                }.padding(.horizontal, 20)
                    .padding(.vertical, 10)
                Spacer()
                Text("Inventory Management")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                // + Button
                Button { 
                    print("-")
                } label: { 
                    Image(systemName: "plus")
                        .font(.system(size: 25, weight: .bold))
                }.padding(.horizontal, 20)
                    .padding(.vertical, 10)

            }
            .foregroundColor(Color.white)
        }
    }
    
    var headerBackground: some View {
        Rectangle()
            .fill(LinearGradient(colors: [
                Color.blue,
                Color(red: 40/55, green: 92/255, blue: 222/255)
            ], startPoint: .bottom, endPoint: .top))
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .edgesIgnoringSafeArea(.top)
    }
}

struct CardView: View {
    let inventory: InventoryModel
    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack {
                Image(systemName: inventory.icon)
                Text(inventory.type)
                    .font(.system(size: 15, weight: .bold))
                Spacer()
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(inventory.statusColor)
                Text(inventory.status)
                    .font(.system(size: 15, weight: .light))
            }.foregroundColor(.gray)
            
            Text(inventory.title)
                .font(.system(size: 16, weight: .bold))
            
            HStack {
                Text("For")
                    .font(.system(size: 15, weight: .light))
                Text(inventory.owner)
                Image(systemName: "chevron.down")
                    .font(.system(size: 13, weight: .bold))
                Spacer()
                Text(inventory.time)
                    .font(.system(size: 15, weight: .light))
            }
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .overlay(
            HStack {
                Rectangle()
                    .fill(inventory.cardColor)
                    .padding(.vertical, -20)
                    .frame(width: 5)
                Spacer()
            }
        )
        .padding(.vertical, 20)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.2), radius: 15, x: 0, y: 0)
        .padding(.vertical, 10)
    }
}


struct InventoryModel: Identifiable {
    let id = UUID()
    let icon: String
    let statusColor: Color
    let type: String
    let title: String
    let status: String
    let owner: String
    let time: String
    let cardColor: Color
    
    static func getInventory() -> [Self] {
        return [
            InventoryModel(icon: "square.stack.3d.up.fill",
                           statusColor: .red,
                           type: "ASSET",
                           title: "Request for a new Apple Macbook Pro",
                           status: "Open",
                           owner: "Juancho",
                           time: "3m",
                           cardColor: .yellow),
            
            InventoryModel(icon: "questionmark.circle.fill",
                           statusColor: .blue,
                           type: "TROUBLESHOOT",
                           title: "Macbook not shutting down properly",
                           status: "In Progress",
                           owner: "Camille",
                           time: "15m",
                           cardColor: .blue),
            
            InventoryModel(icon: "paperplane.fill",
                           statusColor: .green,
                           type: "REQUEST",
                           title: "New Office Supplies Request",
                           status: "Open",
                           owner: "Sarah",
                           time: "5m",
                           cardColor: .green),

            InventoryModel(icon: "hammer.fill",
                           statusColor: .orange,
                           type: "MAINTENANCE",
                           title: "Office Chair Repair",
                           status: "Pending",
                           owner: "Alex",
                           time: "10m",
                           cardColor: .purple),

            InventoryModel(icon: "exclamationmark.triangle.fill",
                           statusColor: .red,
                           type: "ISSUE",
                           title: "Network Connectivity Problem",
                           status: "Open",
                           owner: "Mike",
                           time: "20m",
                           cardColor: .red),

            InventoryModel(icon: "briefcase.fill",
                           statusColor: .green,
                           type: "TASK",
                           title: "Client Meeting Preparation",
                           status: "In Progress",
                           owner: "Emily",
                           time: "30m",
                           cardColor: .teal),

            InventoryModel(icon: "book.fill",
                           statusColor: .blue,
                           type: "KNOWLEDGE",
                           title: "New Employee Handbook",
                           status: "Published",
                           owner: "Dave",
                           time: "1h",
                           cardColor: .pink),
        ]
    } 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
