// Generated by gencpp from file exercise1/SumOfArrayResponse.msg
// DO NOT EDIT!


#ifndef EXERCISE1_MESSAGE_SUMOFARRAYRESPONSE_H
#define EXERCISE1_MESSAGE_SUMOFARRAYRESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace exercise1
{
template <class ContainerAllocator>
struct SumOfArrayResponse_
{
  typedef SumOfArrayResponse_<ContainerAllocator> Type;

  SumOfArrayResponse_()
    : result(0)  {
    }
  SumOfArrayResponse_(const ContainerAllocator& _alloc)
    : result(0)  {
  (void)_alloc;
    }



   typedef int32_t _result_type;
  _result_type result;





  typedef boost::shared_ptr< ::exercise1::SumOfArrayResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::exercise1::SumOfArrayResponse_<ContainerAllocator> const> ConstPtr;

}; // struct SumOfArrayResponse_

typedef ::exercise1::SumOfArrayResponse_<std::allocator<void> > SumOfArrayResponse;

typedef boost::shared_ptr< ::exercise1::SumOfArrayResponse > SumOfArrayResponsePtr;
typedef boost::shared_ptr< ::exercise1::SumOfArrayResponse const> SumOfArrayResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::exercise1::SumOfArrayResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::exercise1::SumOfArrayResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::exercise1::SumOfArrayResponse_<ContainerAllocator1> & lhs, const ::exercise1::SumOfArrayResponse_<ContainerAllocator2> & rhs)
{
  return lhs.result == rhs.result;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::exercise1::SumOfArrayResponse_<ContainerAllocator1> & lhs, const ::exercise1::SumOfArrayResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace exercise1

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::exercise1::SumOfArrayResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::exercise1::SumOfArrayResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::exercise1::SumOfArrayResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::exercise1::SumOfArrayResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::exercise1::SumOfArrayResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::exercise1::SumOfArrayResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::exercise1::SumOfArrayResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "034a8e20d6a306665e3a5b340fab3f09";
  }

  static const char* value(const ::exercise1::SumOfArrayResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x034a8e20d6a30666ULL;
  static const uint64_t static_value2 = 0x5e3a5b340fab3f09ULL;
};

template<class ContainerAllocator>
struct DataType< ::exercise1::SumOfArrayResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "exercise1/SumOfArrayResponse";
  }

  static const char* value(const ::exercise1::SumOfArrayResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::exercise1::SumOfArrayResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int32 result\n"
"\n"
"\n"
;
  }

  static const char* value(const ::exercise1::SumOfArrayResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::exercise1::SumOfArrayResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.result);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct SumOfArrayResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::exercise1::SumOfArrayResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::exercise1::SumOfArrayResponse_<ContainerAllocator>& v)
  {
    s << indent << "result: ";
    Printer<int32_t>::stream(s, indent + "  ", v.result);
  }
};

} // namespace message_operations
} // namespace ros

#endif // EXERCISE1_MESSAGE_SUMOFARRAYRESPONSE_H
