Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9E2153C0D
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 00:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBEXls (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Feb 2020 18:41:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:21263 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBEXls (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Feb 2020 18:41:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 15:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="432036325"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Feb 2020 15:41:45 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izUIj-0004su-6l; Thu, 06 Feb 2020 07:41:45 +0800
Date:   Thu, 6 Feb 2020 07:41:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     kbuild-all@lists.01.org, zohar@linux.ibm.com,
        James.Bottomley@HansenPartnership.com,
        jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2 6/8] ima: Allocate and initialize tfm for each PCR bank
Message-ID: <202002060720.CVTYGnC7%lkp@intel.com>
References: <20200205103317.29356-7-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205103317.29356-7-roberto.sassu@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on integrity/next-integrity]
[also build test WARNING on jss-tpmdd/next v5.5 next-20200205]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Roberto-Sassu/ima-support-stronger-algorithms-for-attestation/20200205-233901
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-154-g1dc00f87-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> security/integrity/ima/ima_crypto.c:72:12: sparse: sparse: symbol 'ima_init_ima_crypto' was not declared. Should it be static?
   security/integrity/ima/ima_crypto.c:545:36: sparse: sparse: invalid assignment: |=
   security/integrity/ima/ima_crypto.c:545:36: sparse:    left side has type unsigned int
   security/integrity/ima/ima_crypto.c:545:36: sparse:    right side has type restricted fmode_t
   security/integrity/ima/ima_crypto.c:565:28: sparse: sparse: invalid assignment: &=
   security/integrity/ima/ima_crypto.c:565:28: sparse:    left side has type unsigned int
   security/integrity/ima/ima_crypto.c:565:28: sparse:    right side has type restricted fmode_t
   security/integrity/ima/ima_crypto.c:592:52: sparse: sparse: restricted __le32 degrades to integer

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
