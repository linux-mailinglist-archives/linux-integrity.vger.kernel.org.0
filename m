Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FA925CC8C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Sep 2020 23:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgICVpF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Sep 2020 17:45:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728037AbgICVpE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Sep 2020 17:45:04 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083LWo9g082046;
        Thu, 3 Sep 2020 17:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=AJJtyDkK71KAtXDoyagJ/qdb1oShYkeR15uEJJIJ9Qk=;
 b=SG5ZKBSyCKdVvkN9Eym4ccOJN5g1/5u2KtTUC8fvLqcIHlJX7u/hgyugadPKKoXa8wD4
 5Vx6mEIbXFvuNkgVGZUJDRvmVNcb8mXiJGok6eAHKvy9wJt8cBShb7YNKkBBoB04MFFo
 WFWUDJs+Yq+2ju0uQ1/YtxMcdKUmOQHyHa+CqFnm3ClARnX6bFnbZ2htM/kGc4Ke2FGV
 6Ucwm6yTvm1U3FBlArU/UVBvZfhtOfkHDxkb6B4Xp3WjIm5/W9SGBmPKUyzsQbm3B4OI
 +vjz9R5KbCWZImvU5O1SRw5k/p4FmnLCp75yDQFDaicCn/eVDQCgKTM+8xJky5PFq2IX rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33b7cfsxv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 17:44:09 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 083LX7j8082506;
        Thu, 3 Sep 2020 17:44:09 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33b7cfsxur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 17:44:09 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 083LgspW030969;
        Thu, 3 Sep 2020 21:44:07 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03wdc.us.ibm.com with ESMTP id 337en9tu7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 21:44:07 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 083Li7dQ52232452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Sep 2020 21:44:07 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EFDAAC05B;
        Thu,  3 Sep 2020 21:44:07 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1774AC059;
        Thu,  3 Sep 2020 21:43:57 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.155.22])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Sep 2020 21:43:57 +0000 (GMT)
References: <20200901195029.30039-1-nramas@linux.microsoft.com>
 <20200901195029.30039-2-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, gregkh@linuxfoundation.org,
        james.morse@arm.com, catalin.marinas@arm.com, sashal@kernel.org,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [PATCH v5 1/3] powerpc: Refactor kexec functions to move arch
 independent code to IMA
In-reply-to: <20200901195029.30039-2-nramas@linux.microsoft.com>
Date:   Thu, 03 Sep 2020 18:43:54 -0300
Message-ID: <87y2lqy1r9.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_14:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 suspectscore=2 mlxlogscore=771 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030189
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> The functions ima_get_kexec_buffer() and ima_free_kexec_buffer() that
> handle carrying forward the IMA measurement logs on kexec for powerpc
> do not have architecture specific code, but they are currently defined
> for powerpc only.
>
> Move these functions to IMA subsystem so that it can be used for other
> architectures as well. A later patch in this series will use these
> functions for carrying forward the IMA measurement log for ARM64.
>
> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
> "linux,ima-kexec-buffer", that is added to the DTB to hold
> the address and the size of the memory reserved to carry
> the IMA measurement log.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

do_get_kexec_buffer() is still duplicated in generic code and powerpc
code. It's a small and simple function though, so not really a problem.

I think you'll need to move over remove_ima_buffer() if you agree with
the comment I'll make on patch 3, in which case the powerpc-specific
do_get_kexec_buffer() can be removed.

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
