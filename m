Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238A93BD699
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jul 2021 14:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhGFMlS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 08:41:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233173AbhGFMhS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 08:37:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 166CY8A8000808;
        Tue, 6 Jul 2021 08:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=W07NfgKqKlaRXCdzw4vr3tXr5dHCmnBJHl0PmGkDj4E=;
 b=ne9qa7w5oXheQOqjyIOE21NgrKeV4xQ1EsWB+uPsbHxK/9XfG3jTO4rYSmn7QiwT20IG
 K3xDz6oInWMYPWe3cRcAvqPivhf55dzp3K/tMSeCxQtlRq0nw9ROqnG5ptr31axNvYEm
 NEimQi/d909H464pve+ac/6i9pntVmKkO5KKhAHLZhlM8Ryo37j2s+uIORK1iBw4YQOO
 ukZHWkNVsms+7ahtJ5faw+4q2agx2ZQK7ZPTTO9F9sRqfalNsZW87UtBBd/p1JNL3LSP
 sbFIcIzSwrCbJuVqcUkGQxkvz0aSWNOnA5Z8rHltlbUp4CbRL0h5HFtyurYBB2vRXNFu sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39m8xsvhgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 08:34:24 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 166CYKx3001724;
        Tue, 6 Jul 2021 08:34:23 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39m8xsvhfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 08:34:23 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 166COuI9031811;
        Tue, 6 Jul 2021 12:34:21 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 39jf5hgnx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 12:34:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 166CYJ7836307436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jul 2021 12:34:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11117AE051;
        Tue,  6 Jul 2021 12:34:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0CC7AE057;
        Tue,  6 Jul 2021 12:34:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.34.2])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jul 2021 12:34:15 +0000 (GMT)
Message-ID: <b90af62dbe71413d76ee297942eadd387dc1ba48.camel@linux.ibm.com>
Subject: Re: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Hao Wu <hao.wu@rubrik.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James.Bottomley@hansenpartnership.com
Date:   Tue, 06 Jul 2021 08:34:14 -0400
In-Reply-To: <CE168D94-C8F1-4DDB-B0F5-66E5F1D58097@rubrik.com>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
         <20210704000754.1384-1-hao.wu@rubrik.com>
         <20210705071531.axxzyvecf52foik2@kernel.org>
         <CE168D94-C8F1-4DDB-B0F5-66E5F1D58097@rubrik.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nkpyrEFygf161cwWS1lAPPIlxFwdSepY
X-Proofpoint-GUID: zrnyJID93glROmJ1aoWrx6MtBsHKZxf6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_06:2021-07-02,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 mlxlogscore=949 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107060061
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-07-05 at 16:09 -0700, Hao Wu wrote:
> > On Jul 5, 2021, at 12:15 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> 
> >> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
> >> ---
> >> Test Plan:
> >> - Run fixed kernel with ATMEL TPM chips and see crash
> >> has been fixed.
> >> - Run fixed kernel with non-ATMEL TPM chips, and confirm
> >> the timeout has not been changed.
> > 
> > The changelog is missing.
> Sorry, I don’t get your point here. Could you help clarify it a bit.
> I did follow the section 14, but I didn’t see anything specifically needed after `---`
> Could you be specific ? Thanks for your time. 

The changes from one version of a patch, or patch set, to the next has
moved around a bit.  Some people put it in the cover letter, others put
it on the individual patches.   It's also moved from within the patch
description to after the dashes.  Documentation/process/submitting-
patches.rst provides an example, but leaves out the word "Changelog".  
For an explanation of what goes into the patch description versus the
Changelog, search for "Other comments relevant only to the moment or
the maintainer".

For example, this version of the patch limits increasing the delay just
for Atmel TPM 1.2 chips.  At minimum it would be included in the
Changelog, but more likely included in the patch description itself and
perhaps even in the Subject line.

thanks,

Mimi

> 
> > Please read section 14 of
> > 
> > https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
> > 
> > /Jarkko
> Hao


