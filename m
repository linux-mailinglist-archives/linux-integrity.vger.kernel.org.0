Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424E284DB3
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Aug 2019 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbfHGNkF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Aug 2019 09:40:05 -0400
Received: from osiris.lip6.fr ([132.227.60.30]:59273 "EHLO osiris.lip6.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388200AbfHGNkF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Aug 2019 09:40:05 -0400
X-Greylist: delayed 1292 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Aug 2019 09:40:02 EDT
Received: from poleia.lip6.fr (poleia.lip6.fr [132.227.201.8])
        by osiris.lip6.fr (8.15.2/8.15.2) with ESMTP id x77DINZx004846;
        Wed, 7 Aug 2019 15:18:23 +0200 (CEST)
Received: from newmail.lip6.fr (localhost [127.0.0.1])
        by poleia.lip6.fr (Postfix) with ESMTPA id 440FE32FC4C;
        Wed,  7 Aug 2019 15:18:23 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 07 Aug 2019 15:18:23 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, kbuild-all@01.org
Subject: Fwd: [integrity:next-queued-testing 8/13]
 security/integrity/ima/ima_modsig.c:81:17-20: ERROR: reference preceded by
 free on line 80
In-Reply-To: <201908072140.Qep3jWIW%lkp@intel.com>
References: <201908072140.Qep3jWIW%lkp@intel.com>
Message-ID: <2ee96e49ade2e30a44fa14840610b432@lip6.fr>
X-Sender: Julia.Lawall@lip6.fr
User-Agent: Roundcube Webmail/1.3.9
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (osiris.lip6.fr [132.227.60.30]); Wed, 07 Aug 2019 15:18:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This looks risky. See lines 80 and 81.

-------- Courriel original --------
Objet: [integrity:next-queued-testing 8/13] 
security/integrity/ima/ima_modsig.c:81:17-20: ERROR: reference preceded 
by free on line 80
Date: 07.08.2019 15:10
De: kbuild test robot <lkp@intel.com>
À: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>

CC: kbuild-all@01.org
CC: linux-integrity@vger.kernel.org
TO: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Mimi Zohar <zohar@linux.ibm.com>

tree:   
https://kernel.googlesource.com/pub/scm/linux/kernel/git/zohar/linux-integrity.git 
next-queued-testing
head:   cd3553a6a5047b7a759803ae3ba3991a901b89f8
commit: 2ebb61778990547b3dd7496bb66d0ac837659b14 [8/13] ima: Implement 
support for module-style appended signatures
:::::: branch date: 6 days ago
:::::: commit date: 6 days ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> security/integrity/ima/ima_modsig.c:81:17-20: ERROR: reference 
>> preceded by free on line 80

git remote add integrity 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/zohar/linux-integrity.git
git remote update integrity
git checkout 2ebb61778990547b3dd7496bb66d0ac837659b14
vim +81 security/integrity/ima/ima_modsig.c

2ebb6177899054 Thiago Jung Bauermann 2019-06-27  41
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  42  /*
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  43   * ima_read_modsig 
- Read modsig from buf.
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  44   *
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  45   * Return: 0 on 
success, error code otherwise.
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  46   */
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  47  int 
ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  48  		    struct modsig 
**modsig)
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  49  {
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  50  	const size_t 
marker_len = strlen(MODULE_SIG_STRING);
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  51  	const struct 
module_signature *sig;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  52  	struct modsig 
*hdr;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  53  	size_t sig_len;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  54  	const void *p;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  55  	int rc;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  56
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  57  	if (buf_len <= 
marker_len + sizeof(*sig))
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  58  		return -ENOENT;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  59
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  60  	p = buf + buf_len 
- marker_len;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  61  	if (memcmp(p, 
MODULE_SIG_STRING, marker_len))
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  62  		return -ENOENT;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  63
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  64  	buf_len -= 
marker_len;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  65  	sig = (const 
struct module_signature *)(p - sizeof(*sig));
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  66
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  67  	rc = 
mod_check_sig(sig, buf_len, func_tokens[func]);
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  68  	if (rc)
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  69  		return rc;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  70
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  71  	sig_len = 
be32_to_cpu(sig->sig_len);
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  72  	buf_len -= sig_len 
+ sizeof(*sig);
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  73
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  74  	hdr = 
kmalloc(sizeof(*hdr), GFP_KERNEL);
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  75  	if (!hdr)
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  76  		return -ENOMEM;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  77
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  78  	hdr->pkcs7_msg = 
pkcs7_parse_message(buf + buf_len, sig_len);
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  79  	if 
(IS_ERR(hdr->pkcs7_msg)) {
2ebb6177899054 Thiago Jung Bauermann 2019-06-27 @80  		kfree(hdr);
2ebb6177899054 Thiago Jung Bauermann 2019-06-27 @81  		return 
PTR_ERR(hdr->pkcs7_msg);
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  82  	}
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  83
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  84  	*modsig = hdr;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  85
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  86  	return 0;
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  87  }
2ebb6177899054 Thiago Jung Bauermann 2019-06-27  88

---
0-DAY kernel test infrastructure                Open Source Technology 
Center
https://lists.01.org/pipermail/kbuild-all                   Intel 
Corporation
