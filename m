Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191C93BDB4C
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jul 2021 18:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhGFQ0P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 12:26:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229999AbhGFQ0O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 12:26:14 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 166G7D01006902;
        Tue, 6 Jul 2021 12:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=GsRC6B2uZ7A6WvUnuicRfnlEhv7A1WBcW3gHKAqYmdk=;
 b=oyQco61RTy90ks6IACGdI39gF2jgm7RCKwVu4m5xEEoJ+k8WIOg2JtXvhNcVUZNAKBwi
 6rdeDMUtOZkxU0h+ZOvIy2D7Z856UkT1b/kwnrsovjtt3KU/mf7VvZf7xWptIUKGUI6/
 WwMgcz0/RMJOpPzCoeHTz4yNisjiD1cHsGNL0lLIJ9Z7BTdcNo6VtQZblhwsUH+xxxKw
 bAaq0rCQyDEXQ2v09qqI+FZupZf6cuV1fBCJR6mn6TFtYmxyXVTR1sGHgHb3UcNfXVsB
 XKH3Ho8E22pDpJoQgxIq1nUEtlxiKyMlu0z879e5UY+PNY1jDY00uLNVXritj/a4Lf04 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39m8bmcfcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 12:23:33 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 166G7fSR008631;
        Tue, 6 Jul 2021 12:23:33 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39m8bmcfbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 12:23:33 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 166GIOWh019224;
        Tue, 6 Jul 2021 16:23:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 39jfh8sbqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 16:23:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 166GNSeD34603406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jul 2021 16:23:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DC0CA4040;
        Tue,  6 Jul 2021 16:23:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97453A404D;
        Tue,  6 Jul 2021 16:23:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.34.2])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jul 2021 16:23:27 +0000 (GMT)
Message-ID: <7d201d4724e7399f87c0cc2f7291cfd13351d156.camel@linux.ibm.com>
Subject: Re: [PATCH v7 0/3] ima-evm-utils: Add --keyid option
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 06 Jul 2021 12:23:26 -0400
In-Reply-To: <20210701011323.2377251-1-vt@altlinux.org>
References: <20210701011323.2377251-1-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aOTqpP0hnBaHoukfoNJ29siyPSW_Ko6o
X-Proofpoint-ORIG-GUID: 7uXGJYgFhUX-tY1l-DQ7Ld9sGGycu7SB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_09:2021-07-06,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060075
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Thu, 2021-07-01 at 04:13 +0300, Vitaly Chikunov wrote:
> Allow user to set signature's keyid using `--keyid' option. Keyid should
> correspond to SKID in certificate. When keyid is calculated using SHA-1
> in libimaevm it may mismatch keyid extracted by the kernel from SKID of
> certificate (the way public key is presented to the kernel), thus making
> signatures not verifiable. This may happen when certificate is using non
> SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
> As a last resort user may specify arbitrary keyid using the new option.
> Certificate filename could be used instead of the hex number with
> `--keyid-from-cert' option. And, third option is to read keyid from the
> cert appended to the key file.
> 
> These commits create backward incompatible ABI change for libimaevm,
> thus soname should be incremented on release.

I haven't started using Github actions.  Here are some new Travis
complaints:

Alpine:
libimaevm.c: In function 'sign_hash_v2':
libimaevm.c:996:47: warning: taking address of packed member of 'struct
signature_v2_hdr' may result in an unaligned pointer value [-Waddress-
of-packed-member]
  996 |   int keyid_read_failed = read_keyid_from_key(&hdr->keyid,
keyfile);
      |                                               ^~~~~~~~~~~
libimaevm.c:999:18: warning: taking address of packed member of 'struct
signature_v2_hdr' may result in an unaligned pointer value [-Waddress-
of-packed-member]
  999 |    calc_keyid_v2(&hdr->keyid, name, pkey);
      |                  ^~~~~~~~~~~

centos:
./.libs/libimaevm.so: undefined reference to `X509_get0_subject_key_id'
./.libs/libimaevm.so: undefined reference to `ASN1_STRING_get0_data'

xenial:
libimaevm.c: In function 'extract_keyid':
libimaevm.c:695:2: warning: implicit declaration of function
'X509_get0_subject_key_id' [-Wimplicit-function-declaration]
  if (!(skid = X509_get0_subject_key_id(x))) {
  ^
libimaevm.c:695:13: warning: assignment makes pointer from integer
without a cast [enabled by default]
  if (!(skid = X509_get0_subject_key_id(x))) {

thanks,

Mimi

