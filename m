Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E61249064
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 23:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgHRVyT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 17:54:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726783AbgHRVyS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 17:54:18 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07ILaY55150490;
        Tue, 18 Aug 2020 17:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2C1ttUcKvuzm1nhH8+fCBOxFy+7kQqlwynFkPYxBDu4=;
 b=UGYg1vVsH3UOBhpAJrhvSLE8tOExGvDvrNr/tFJTRBDOck7wGXMP9EM8fG6yQUUAW6Vr
 yweedqVdi+B7DiuQKKs6qmf3/6Imebu00EEZUXPLe2X+V70xpGsm2uY7rhzThvdCakT1
 b54Z/doeTJU4ITUOFBHwZ0Z9oMXIeHvfoisSd8xwzg0ZfbCD7sLgmahY3cErH9nzYM1j
 h6GWdho+ES5fX856rOC2GFlDQA80YE8NFgp9I9FbTXzZ7E5b665Wib9arqiI5bVSTRAx
 Ez9wdjvp8aHDKljRyJPyWdx4y7cBN3PC61HoJpAWla/NqiEIS8fCQaoy3T+2ISdb0qEF hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3304scq79y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 17:54:13 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07ILdAUR168274;
        Tue, 18 Aug 2020 17:54:13 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3304scq79a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 17:54:12 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07ILoTCv012251;
        Tue, 18 Aug 2020 21:54:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3304bbrp6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 21:54:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07ILs84b31261094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 21:54:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FCB1A4062;
        Tue, 18 Aug 2020 21:54:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2ED0A405F;
        Tue, 18 Aug 2020 21:54:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.9.198])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Aug 2020 21:54:06 +0000 (GMT)
Message-ID: <4f205c34d7b41325c3c46e485f07bc716c917d83.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 0/9] Docker based Travis CI builds
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Date:   Tue, 18 Aug 2020 17:54:05 -0400
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_15:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180154
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Thu, 2020-08-13 at 20:25 +0200, Petr Vorel wrote:
> Hi,
> 
> we talked about Docker based Travis CI builds.
> Here they are [1]. Working on it revealed few bugs, that's why they're
> included.
> 
> I've resent 2 commits ("man:" prefix).
> 
> I haven't addressed Mimi's suggestion to replace ibmswtpm2 with libtmps/swtpm [2].

To summarize:
- Add libtpms/swtpm support
- Remove debugging from travis/fedora.sh 
- CentOS tss & tss2-devel issues
- Petr todo's comment:
  * add pgrep and pkill to _require (fix of a different commit)
  * add magic constant 114 to exit codes (in tests/functions.sh)
  * I'd like reuse exit codes in build.sh. I could source tests/functions.sh (they
    look to be general enough, just I didn't like script in root directory depending
    on it, as it's general enough for build without testing) have these constants in
    separate file.

swtpm: patch was posted, reviewed, and fixed.

CentOS: Our internal Travis on ppc64 is installing both tpm2-tss-2.0.0-
4.el8.x86_64.rpm and tpm2-tss-devel-2.0.0-4.el8.x86_64.rpm on CentOS. 
In general, the "boot_aggregate.test" is only run if both a software
TPM and the tsseventextend exist.  If either one of them are missing,
the test is skipped.  For CentOS on x86, the "boot_aggregate" would be
skipped.

Left is Petr's "todo's" comment.  Petr, would these be additional
patches on top of the existing ones or were you planning on re-posting
them?   If these are additional patches, I can remove the debugging
from travis/fedora.sh in patch 9/9.  Please let me know how you want to
go forward.

thanks,

Mimi

