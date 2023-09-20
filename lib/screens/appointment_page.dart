import 'package:doctor_app1/utils/config.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

//enum for appointment status
enum FilterStatus {upcoming , complete , cancel}
class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [
    {
      "doctor_name":"Dr.Sandeep Chopra",
      "doctor_profile":"assets/doctor_2.jpg",
      "category":"Dental",
      "status":FilterStatus.upcoming
    },
    {
      "doctor_name":"Dr.Chetna Chopra",
      "doctor_profile":"assets/doctor_3.jpg",
      "category":"Respiration",
      "status":FilterStatus.complete,
    },
    {
      "doctor_name":"Dr.Tanay Chopra",
      "doctor_profile":"assets/doctor_4.jpg",
      "category":"Cardiology",
      "status":FilterStatus.complete,
    },
    {
      "doctor_name":"Dr.Avinash Chopra",
      "doctor_profile":"assets/doctor_5.jpg",
      "category":"General",
      "status":FilterStatus.cancel,
    },

  ];
  @override
  Widget build(BuildContext context) {
    //return filterd appointment
    List<dynamic> filteredSchedules = schedules.where((var schedule) {
      // switch(schedule['status']){
      //   case 'upcoming':
      //     schedule['status'] = FilterStatus.upcoming;
      //     break;
      //   case 'complete':
      //     schedule['status'] = FilterStatus.upcoming;
      //     break;
      //   case 'cancel':
      //     schedule['status'] = FilterStatus.upcoming;
      //     break;
      //
      // }
      return schedule['status'] == status;
    }).toList();
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:20, top:20,right:20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              const Text('Appointment Schedule',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
              Config.spaceSmall,
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //this is filter tabs
                        for (FilterStatus filterStatus in FilterStatus.values )
                          Expanded(
                              child:GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if(filterStatus == FilterStatus.upcoming){
                                      status = FilterStatus.upcoming;
                                      _alignment = Alignment.centerLeft;
                                    }else if (filterStatus == FilterStatus.complete){
                                      status = FilterStatus.complete;
                                      _alignment = Alignment.center;
                                    }else if (filterStatus == FilterStatus.cancel){
                                      status = FilterStatus.cancel;
                                      _alignment = Alignment.centerRight;
                                    }
                                  });
                                },

                                child: Center(
                                    child: Text(filterStatus.name),
                                ),
                              ),
                          ),

                      ],
                    ),

                  ),
                  AnimatedAlign(
                    alignment: _alignment,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Config.primaryColor,
                        borderRadius: BorderRadius.circular(20),

                      ) ,
                      child: Center(
                        child: Text(
                          status.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      )

                    ),
                  ),

                ],
              ),
              Config.spaceSmall,
              Expanded(
                child: ListView.builder(
                  itemCount: filteredSchedules.length,
                    itemBuilder: ((context,index){
                      var _schedule = filteredSchedules[index];
                      bool isLastElement = filteredSchedules.length + 1 == index;
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: !isLastElement
                            ? const EdgeInsets.only(bottom: 20)
                            : EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(_schedule['doctor_profile']),
                                      ),
                                      const SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children : [
                                          Text(
                                            _schedule['doctor_name'],
                                            style: const TextStyle(
                                              color:Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 5,),
                                          Text(
                                            _schedule['category'],
                                            style: const TextStyle(
                                              color:Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Config.spaceSmall,
                                        ]
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  const ScheduleCard(),
                                  const SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {},
                                            child : const Text(
                                              'Cancel',
                                              style:
                                                TextStyle(color: Config.primaryColor),
                                            )

                                      ),),
                                      Expanded(
                                        child: OutlinedButton(
                                            style:
                                            OutlinedButton.styleFrom(
                                              backgroundColor: Config.primaryColor,
                                            ),
                                            onPressed: () {},
                                            child : const Text(
                                              'Reschedule',
                                              style:
                                              TextStyle(color: Colors.white),
                                            )

                                        ),),
                                      const SizedBox(height: 20,),
                                    ]
                                  ),
                                ],
                              ),
                            ),

                      );
                    })
                ),
              ),
            ],
          ),
        )
    );

  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10)
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Icon (Icons. calendar_today,
            color: Config.primaryColor,
            size: 15,
          ),
          SizedBox (width: 5,),
          Text (
            'Monday, 11/28/2022',
            style: TextStyle(color: Config.primaryColor),
          ),
          SizedBox(width: 20,),
          Icon (Icons.access_alarm,
            color: Config.primaryColor,
            size: 17,
          ),
          SizedBox (width: 5,),
          Flexible (child: Text('2:00 PM', style: TextStyle(color:Colors.white)))
        ],
      ),
    );
  }

}