Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3AEA11BC2F
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 19:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLKSup (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 13:50:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:34199 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfLKSup (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 13:50:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 10:36:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="215864506"
Received: from tstruk-mobl1.jf.intel.com (HELO [10.7.196.67]) ([10.7.196.67])
  by orsmga006.jf.intel.com with ESMTP; 11 Dec 2019 10:36:15 -0800
Subject: Re: [PROBLEM]: WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
To:     Jeffrin Jose <jeffrin@rajagiritech.edu.in>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Will Deacon <will@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
References: <20191207173420.GA5280@debian>
 <20191209103432.GC3306@willie-the-truck>
 <20191209202552.GK19243@linux.intel.com>
 <34e5340f-de75-f20e-7898-6142eac45c13@intel.com>
 <20191211151701.GA3643@debian>
From:   Tadeusz Struk <tadeusz.struk@intel.com>
Autocrypt: addr=tadeusz.struk@intel.com; keydata=
 mQGNBF2okUMBDADGYZuwqK87k717uEyQ5hqo9X9ICnzpPt38ekB634MdtBwdK8KAFRWIpnT9
 fb5bt/AFgGc1gke/Nr8PFsFcRiNTDuWpwO/zJdWWp+fdnB9dKI0usYY9+Y5Q3lhBeiBN7mDK
 fAoFjyeufKzY3pOM9Gy6FvGQjDyLm2H5siW0IKAsMjAiQ35qI7hednM2XECHqewt4yzxvPZr
 LpgpFvR43nJBUGULGPWqv0usVircd1bBJ4D24j/kaYmuDeyex/HdqTV8sWBx3NFFKtyZB7FV
 EPekbHIxaRxg3kgZzCKXrwoufLR5ErGO/oqJmGjuCMWp14iZ0mtN4BzYdhzqHmtJhc8/nSwV
 NIZUF+JpMk/KpYcPlpmMzBcLKHkAhEvIEoynKCcFHqNUjeu+tqL4Nc6Wl36T2EQw3u9hDk4Y
 uX4ZGe6BzADl8Sphgyld99I4jAeoEzSCbWnqS411iVPXyxfe+46zuW3ORncxNoyy3EqGu8m5
 347fgFADQpc9+jdc1qFcxncAEQEAAbQnVGFkZXVzeiBTdHJ1ayA8dGFkZXVzei5zdHJ1a0Bp
 bnRlbC5jb20+iQHUBBMBCAA+FiEE91vcGmaCEzGCRUztOkAW4c1UqhwFAl2okUcCGwMFCQHh
 M4AFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOkAW4c1UqhwVZQv/dTaTLe1s6xFyAkYJ
 aK8IqKOYo2s29bTDoeul7U2WFivgryGRX3mNblMfV6lwwRcNfjSF+gOVrT6+N1l2vrDmqtPG
 ywKjrL18C7TssAxj7oIDSdRCHbIRjHs6N2jmeg4MPOfBHI3saeatBlDJAVfDMLIey412agTV
 kuVOGkPvMaqB9vh9dZhLXdiRy8Hb4mHvEDR3w5YOGHz0dPkH97WS3y28b9OOLcXShieCW/cJ
 vRpWVI5qod6oEqJIx7AKh8Albmj6U5wyOHWl/ZnmPgacVzrYTF/po/mSL6cIR5p2gnaINnkf
 h9fHkmhZgwwuw5Ua4DmAyWw9bmF7VYcAdnSbyLwl7WF9Nb7Lg1e4R1eG6JW88xEEOVonn9ML
 GUQ+ts5i1L3SwwL9R5WCmRhfVcTNERu2BWbuHjoVEccxhSG2ESKqqbPlnL7zVwcMYz4aIO7S
 XJUQAxAVz4pHkuQQg2+XjVuxG/IB4PEhTfeyIZ/OWmN+m+qTYbu1ebNeLXaG3lu2uQGNBF2o
 kUcBDACtgd7j0GWo05BN68gCC10t3PIEhQCAQhOKIFBpfv8yGvrvw9bnAN6FeU86CDERBhQS
 KlthNlynuJGa+ws2LtGidUDTw2W/Pi7vhV/45bVh5ldK/CNioI7I9Kcof5e2ooxmjOV+znst
 rc4zu4YYAChdRArXBVw6TyTucuNdctgHfAC5RJXcq7qtnbBarp3yKZdMwIwKlNTCFl8kbsBD
 2uHI2xcVWQ2iF51s1wzsaJa3jK8Chkld/uVgqdo86zgFcl8DQFgytXz+q/eFsca3Ca95fNWc
 bDeOtCjfNloeuYCiEAK0KrwAG16qkeoBvmG0AHrOIwAdCJgE2cDsBfhMmSy3qiQ6E0+STqw9
 OwYo9k+fZwfoxOnAIRD3T0SaTwc8GGf8fJRtL+oiGUzXVU+FsKFgL0xdMUdCioLFOjWyChXm
 W9LbLHWe0+yJSKs+qsMgObAGPEUszx4/fckYrQ3TzbvosQyQLpOxRDMAZOmxsqk8qxNvtwkq
 2dk1/u9px+syaxMAEQEAAYkBvAQYAQgAJhYhBPdb3BpmghMxgkVM7TpAFuHNVKocBQJdqJFH
 AhsMBQkB4TOAAAoJEDpAFuHNVKocGYML/37TFWRz/VbhazKlMxEX+JI76q9cQ2KWcBEn/OYY
 PLHXFzYEKrBMUxzpUaxRLeHadIeGI+4c2EDfFRigzY4GiseN8HNhl5t2jEb5FX/M6WHVCfNt
 vGz6dVAaES6z4UqWW8cP1insosSFi5slHjoUNk9Sx9FQ/oIX9FemLxxH4HcFlxGmUrVUiiof
 en/LmOP4UBVPxRJ20UeFOD3XcwQerS0r4LEK2Zpl/lB7WbGSCZjoVq9xhv5i+9Z04KvVkTCY
 T/vfPu+7KPf+gxGMZZqi+mILWBzCbhOa25HOjeJ780zGDQa05DF6WWepIlNYoiaYeqwhcmWP
 gwizcH5TjTP7SF96/2USKmZCsgKKiVy4a9yHyafeDxCa6NwL1wVRaCqJhdtjgfGrcSx0u++F
 H5Vo0zSBk5Nx0fx2HT16roAnfoOj4wLa/0xVtt+9XXdcoueQwO4imuUeR1Spm1Yni1oBuaR3
 yvcQkH/25MiQZ3/8hU+0Tpfy9SPQyBxrtguvPBPfRg==
Message-ID: <00804293-7f60-0ac1-fe01-0143eb508a2b@intel.com>
Date:   Wed, 11 Dec 2019 10:36:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211151701.GA3643@debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/11/19 7:17 AM, Jeffrin Jose wrote:
> above patch shows errors when i try to apply it.
> --------------------x------------------------x------------------
> error: git diff header lacks filename information when removing 1 leading pathname component (line 2)
> when i did  related to this "diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c"
> i get another error
> error: corrupt patch at line 27
> ----------------------x------------------------x-----------------
> 
> i use "git apply"

Hi,
This was just a copy and paste that wasn't meant to be applied.
If you want to try it please use the patch that I sent later:
https://patchwork.kernel.org/patch/11283317/

Thanks,
-- 
Tadeusz
