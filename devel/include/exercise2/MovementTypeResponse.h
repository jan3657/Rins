// Generated by gencpp from file exercise2/MovementTypeResponse.msg
// DO NOT EDIT!


#ifndef EXERCISE2_MESSAGE_MOVEMENTTYPERESPONSE_H
#define EXERCISE2_MESSAGE_MOVEMENTTYPERESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace exercise2
{
template <class ContainerAllocator>
struct MovementTypeResponse_
{
  typedef MovementTypeResponse_<ContainerAllocator> Type;

  MovementTypeResponse_()
    : lastDrawnShape()  {
    }
  MovementTypeResponse_(const ContainerAllocator& _alloc)
    : lastDrawnShape(_alloc)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _lastDrawnShape_type;
  _lastDrawnShape_type lastDrawnShape;





  typedef boost::shared_ptr< ::exercise2::MovementTypeResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::exercise2::MovementTypeResponse_<ContainerAllocator> const> ConstPtr;

}; // struct MovementTypeResponse_

typedef ::exercise2::MovementTypeResponse_<std::allocator<void> > MovementTypeResponse;

typedef boost::shared_ptr< ::exercise2::MovementTypeResponse > MovementTypeResponsePtr;
typedef boost::shared_ptr< ::exercise2::MovementTypeResponse const> MovementTypeResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::exercise2::MovementTypeResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::exercise2::MovementTypeResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::exercise2::MovementTypeResponse_<ContainerAllocator1> & lhs, const ::exercise2::MovementTypeResponse_<ContainerAllocator2> & rhs)
{
  return lhs.lastDrawnShape == rhs.lastDrawnShape;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::exercise2::MovementTypeResponse_<ContainerAllocator1> & lhs, const ::exercise2::MovementTypeResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace exercise2

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::exercise2::MovementTypeResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::exercise2::MovementTypeResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::exercise2::MovementTypeResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::exercise2::MovementTypeResponse_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::exercise2::MovementTypeResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::exercise2::MovementTypeResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::exercise2::MovementTypeResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "481ecc921d6d791c3739bcd08045190b";
  }

  static const char* value(const ::exercise2::MovementTypeResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x481ecc921d6d791cULL;
  static const uint64_t static_value2 = 0x3739bcd08045190bULL;
};

template<class ContainerAllocator>
struct DataType< ::exercise2::MovementTypeResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "exercise2/MovementTypeResponse";
  }

  static const char* value(const ::exercise2::MovementTypeResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::exercise2::MovementTypeResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "string lastDrawnShape\n"
"\n"
"\n"
;
  }

  static const char* value(const ::exercise2::MovementTypeResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::exercise2::MovementTypeResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.lastDrawnShape);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct MovementTypeResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::exercise2::MovementTypeResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::exercise2::MovementTypeResponse_<ContainerAllocator>& v)
  {
    s << indent << "lastDrawnShape: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.lastDrawnShape);
  }
};

} // namespace message_operations
} // namespace ros

#endif // EXERCISE2_MESSAGE_MOVEMENTTYPERESPONSE_H
