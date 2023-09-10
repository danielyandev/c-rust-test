// Sorting a slice in ascending order using Merge Sort
#[no_mangle]
pub extern "C" fn mergeSort(arr: *mut i32, len: usize) {
    if len <= 1 {
        return;
    }

    unsafe {
        let mid = len / 2;

        // Create mutable slices from the pointer and calculate offsets
        let left = std::slice::from_raw_parts_mut(arr, mid);
        let right = std::slice::from_raw_parts_mut(arr.offset(mid as isize), len - mid);

        mergeSort(left.as_mut_ptr(), mid);
        mergeSort(right.as_mut_ptr(), len - mid);

        let mut result = Vec::with_capacity(len);

        let (mut i, mut j) = (0, 0);

        while i < mid && j < len - mid {
            if left[i] <= right[j] {
                result.push(left[i]);
                i += 1;
            } else {
                result.push(right[j]);
                j += 1;
            }
        }

        while i < mid {
            result.push(left[i]);
            i += 1;
        }

        while j < len - mid {
            result.push(right[j]);
            j += 1;
        }

        // Copy the sorted elements back to the original array
        arr.copy_from_nonoverlapping(result.as_ptr(), len);
    }
}
