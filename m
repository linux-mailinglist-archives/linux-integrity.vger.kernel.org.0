Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788A42B2E5D
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Nov 2020 17:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKNQMJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 14 Nov 2020 11:12:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:47089 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgKNQMJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Nov 2020 11:12:09 -0500
IronPort-SDR: eQqBsQWu3C7WkVXsUOVRwwv+cgdpp75lFHrfaqVL8Np7ljah4WtWDhZHlbpUD2sh+/rJXyCBVP
 yUa3s+DqyMKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="169803562"
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="gz'50?scan'50,208,50";a="169803562"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2020 08:12:07 -0800
IronPort-SDR: GqTgWz54JVbg915iTePLtJIlT7eYaEn/+u2LuRB+50frSixywCae15UY5h74l35UO1foF1uz7J
 FelqVlHtsMsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="gz'50?scan'50,208,50";a="400029550"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Nov 2020 08:12:03 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdy9j-0000uQ-7m; Sat, 14 Nov 2020 16:12:03 +0000
Date:   Sun, 15 Nov 2020 00:11:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        peterz@infradead.org
Cc:     kbuild-all@lists.01.org, Shuah Khan <skhan@linuxfoundation.org>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 13/13] security/integrity/ima: converts stats to
 seqnum_ops
Message-ID: <202011150009.G3K9oqp0-lkp@intel.com>
References: <581db581b900a01887ecfc3ec6b92e19d54cd2d9.1605287778.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <581db581b900a01887ecfc3ec6b92e19d54cd2d9.1605287778.git.skhan@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shuah,

I love your patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on integrity/next-integrity char-misc/char-misc-testing usb/usb-testing linus/master v5.10-rc3 next-20201113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shuah-Khan/Introduce-seqnum_ops/20201114-014959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git f4acd33c446b2ba97f1552a4da90050109d01ca7
config: nios2-randconfig-r023-20201114 (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b86077d3629fe6d16070d95b8331344258dcaed2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shuah-Khan/Introduce-seqnum_ops/20201114-014959
        git checkout b86077d3629fe6d16070d95b8331344258dcaed2
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from security/integrity/ima/ima_fs.c:26:
   security/integrity/ima/ima.h:178:18: error: field 'len' has incomplete type
     178 |  struct seqnum64 len; /* number of stored measurements in the list */
         |                  ^~~
   security/integrity/ima/ima.h:179:18: error: field 'violations' has incomplete type
     179 |  struct seqnum64 violations;
         |                  ^~~~~~~~~~
   security/integrity/ima/ima_fs.c: In function 'ima_show_htable_value':
>> security/integrity/ima/ima_fs.c:48:52: error: implicit declaration of function 'seqnum64_fetch'; did you mean 'seqnum32_fetch'? [-Werror=implicit-function-declaration]
      48 |  len = scnprintf(tmpbuf, sizeof(tmpbuf), "%llu\n", seqnum64_fetch(val));
         |                                                    ^~~~~~~~~~~~~~
         |                                                    seqnum32_fetch
>> security/integrity/ima/ima_fs.c:48:46: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'int' [-Wformat=]
      48 |  len = scnprintf(tmpbuf, sizeof(tmpbuf), "%llu\n", seqnum64_fetch(val));
         |                                           ~~~^     ~~~~~~~~~~~~~~~~~~~
         |                                              |     |
         |                                              |     int
         |                                              long long unsigned int
         |                                           %u
   security/integrity/ima/ima_fs.c: In function 'ima_show_htable_violations':
   security/integrity/ima/ima_fs.c:57:1: error: control reaches end of non-void function [-Werror=return-type]
      57 | }
         | ^
   security/integrity/ima/ima_fs.c: In function 'ima_show_measurements_count':
   security/integrity/ima/ima_fs.c:70:1: error: control reaches end of non-void function [-Werror=return-type]
      70 | }
         | ^
   cc1: some warnings being treated as errors
--
   In file included from security/integrity/ima/ima_queue.c:21:
   security/integrity/ima/ima.h:178:18: error: field 'len' has incomplete type
     178 |  struct seqnum64 len; /* number of stored measurements in the list */
         |                  ^~~
   security/integrity/ima/ima.h:179:18: error: field 'violations' has incomplete type
     179 |  struct seqnum64 violations;
         |                  ^~~~~~~~~~
   In file included from security/integrity/ima/ima_queue.c:20:
   include/linux/seqnum_ops.h:40:27: error: field name not in record or union initializer
      40 | #define SEQNUM_INIT(i)  { .seqnum = ATOMIC_INIT(i) }
         |                           ^
   security/integrity/ima/ima_queue.c:37:9: note: in expansion of macro 'SEQNUM_INIT'
      37 |  .len = SEQNUM_INIT(0),
         |         ^~~~~~~~~~~
   include/linux/seqnum_ops.h:40:27: note: (near initialization for 'ima_htable.len')
      40 | #define SEQNUM_INIT(i)  { .seqnum = ATOMIC_INIT(i) }
         |                           ^
   security/integrity/ima/ima_queue.c:37:9: note: in expansion of macro 'SEQNUM_INIT'
      37 |  .len = SEQNUM_INIT(0),
         |         ^~~~~~~~~~~
   include/linux/seqnum_ops.h:40:27: error: field name not in record or union initializer
      40 | #define SEQNUM_INIT(i)  { .seqnum = ATOMIC_INIT(i) }
         |                           ^
   security/integrity/ima/ima_queue.c:38:16: note: in expansion of macro 'SEQNUM_INIT'
      38 |  .violations = SEQNUM_INIT(0),
         |                ^~~~~~~~~~~
   include/linux/seqnum_ops.h:40:27: note: (near initialization for 'ima_htable.violations')
      40 | #define SEQNUM_INIT(i)  { .seqnum = ATOMIC_INIT(i) }
         |                           ^
   security/integrity/ima/ima_queue.c:38:16: note: in expansion of macro 'SEQNUM_INIT'
      38 |  .violations = SEQNUM_INIT(0),
         |                ^~~~~~~~~~~
   security/integrity/ima/ima_queue.c: In function 'ima_add_digest_entry':
>> security/integrity/ima/ima_queue.c:110:2: error: implicit declaration of function 'seqnum64_inc_return'; did you mean 'seqnum32_inc_return'? [-Werror=implicit-function-declaration]
     110 |  seqnum64_inc_return(&ima_htable.len);
         |  ^~~~~~~~~~~~~~~~~~~
         |  seqnum32_inc_return
   cc1: some warnings being treated as errors
--
   In file included from security/integrity/ima/ima_api.c:19:
   security/integrity/ima/ima.h:178:18: error: field 'len' has incomplete type
     178 |  struct seqnum64 len; /* number of stored measurements in the list */
         |                  ^~~
   security/integrity/ima/ima.h:179:18: error: field 'violations' has incomplete type
     179 |  struct seqnum64 violations;
         |                  ^~~~~~~~~~
   security/integrity/ima/ima_api.c: In function 'ima_add_violation':
>> security/integrity/ima/ima_api.c:148:2: error: implicit declaration of function 'seqnum64_inc_return'; did you mean 'seqnum32_inc_return'? [-Werror=implicit-function-declaration]
     148 |  seqnum64_inc_return(&ima_htable.violations);
         |  ^~~~~~~~~~~~~~~~~~~
         |  seqnum32_inc_return
   cc1: some warnings being treated as errors

vim +48 security/integrity/ima/ima_fs.c

    41	
    42	static ssize_t ima_show_htable_value(char __user *buf, size_t count,
    43					     loff_t *ppos, struct seqnum64 *val)
    44	{
    45		char tmpbuf[32];	/* greater than largest 'long' string value */
    46		ssize_t len;
    47	
  > 48		len = scnprintf(tmpbuf, sizeof(tmpbuf), "%llu\n", seqnum64_fetch(val));
    49		return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
    50	}
    51	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--7JfCtLOvnd9MIVvH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
FiUlunDGluwv55fS0Vl4AQA=

--7JfCtLOvnd9MIVvH--
