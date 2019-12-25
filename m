Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDA912A5E6
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2019 05:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLYEya (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Dec 2019 23:54:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:61021 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfLYEya (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Dec 2019 23:54:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2019 20:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,353,1571727600"; 
   d="scan'208";a="392040361"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Dec 2019 20:54:28 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ijygl-00057O-U7; Wed, 25 Dec 2019 12:54:27 +0800
Date:   Wed, 25 Dec 2019 12:54:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [integrity:next-integrity-testing 3/5]
 security/integrity/ima/ima_asymmetric_keys.c:70:6: sparse: sparse: symbol
 'ima_queue_key' was not declared. Should it be static?
Message-ID: <201912251234.hUAOr3cc%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-testing
head:   11b771ffff8fc0bfc176b829d986896a7d97a44c
commit: 466a4c055a9b9efc8704591bbfa9041c77f66c46 [3/5] IMA: Define workqueue for early boot "key" measurements
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        git checkout 466a4c055a9b9efc8704591bbfa9041c77f66c46
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> security/integrity/ima/ima_asymmetric_keys.c:70:6: sparse: sparse: symbol 'ima_queue_key' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
