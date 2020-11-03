Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F562A5078
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 20:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgKCTvP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 14:51:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgKCTvP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 14:51:15 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3Jj9pb115981;
        Tue, 3 Nov 2020 14:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+66DPkECYdQpeEzmGyKfX3+BsgKJF1hDIdkz4my3BgA=;
 b=lxBhjicdxe2Tuf/8Y22fE2Zgx2mF25E6ertB2bfzi7UlHVL80CVmjl4Dpy4HiYsEPUgI
 nwlRQNOSlGh4UMnYhlg4xN9+zZS/lOcnsDWtLLceUUjvaiScE465gThsnL701vEGqrp0
 SGLg4Bo/gdjJhKNG4DqGw8DBUUPKiwcpdi3HsJJAcm10HeomtRf+HgiQp4Om0vkLKeIn
 MhM9zJq5t4y1HGm1T4ygd2xyWSqJoaa+f0/F+d/tngirxnmPYm9MHrZzlGYQaUAvuV82
 B7ll5AEkw+mz0z3hYpikUk9GGQylpGw8qM/vL7XfeRd93VrnW2zLHOoSc9q8NNMBvvu7 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kdmqr34b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:50:34 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3JjZXs116523;
        Tue, 3 Nov 2020 14:50:33 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kdmqr33b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:50:33 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3JhCNT016379;
        Tue, 3 Nov 2020 19:50:31 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34h0fcukhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 19:50:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3JoSaZ62521620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 19:50:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF769A4060;
        Tue,  3 Nov 2020 19:50:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34863A4054;
        Tue,  3 Nov 2020 19:50:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.125.87])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Nov 2020 19:50:22 +0000 (GMT)
Message-ID: <f45e865c005ce05a6bc376e14c089937197e2aeb.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] powerpc: Refactor kexec functions to move arch
 independent code to ima
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Date:   Tue, 03 Nov 2020 14:50:21 -0500
In-Reply-To: <397f1bbf-46bf-b522-616b-2e006ef30e70@linux.microsoft.com>
References: <20201030174429.29893-1-nramas@linux.microsoft.com>
         <20201030174429.29893-3-nramas@linux.microsoft.com>
         <87f63dc12739b346d556f85537324d3ae055097d.camel@linux.ibm.com>
         <397f1bbf-46bf-b522-616b-2e006ef30e70@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 suspectscore=2 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-11-03 at 11:23 -0800, Lakshmi Ramasubramanian wrote:
> On 11/3/20 6:55 AM, Mimi Zohar wrote:
> 
> Hi Mimi,
> 
> > 
> > On Fri, 2020-10-30 at 10:44 -0700, Lakshmi Ramasubramanian wrote:
> >> The functions ima_get_kexec_buffer() and ima_free_kexec_buffer(),
> >> that handle carrying forward the IMA measurement logs on kexec for
> >> powerpc do not have architecture specific code, but they are currently
> >> defined for powerpc only.
> >>
> >> Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to IMA
> >> subsystem. A later patch in this series will use these functions for
> >> carrying forward the IMA measurement log for ARM64.
> >>
> >> With the above refactoring arch/powerpc/kexec/ima.c contains only
> >> functions used when CONFIG_IMA_KEXEC is enabled. Update Makefile
> >> in arch/powerpc/kexec to include arch/powerpc/kexec/ima.c only
> >> when CONFIG_IMA_KEXEC is enabled.
> >>
> >> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> >> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> >> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > 
> > Similar comments to 1/4.
> > -  Last line of first paragraph can be rephrased like " ... on kexec,
> > do not contain architecture specific code, but are currently limited to
> > powerpc."
> Sure.
> 
> > -  This patch should be limited to moving existing functions.
> > Truncate the Subject line to "Move arch independent IMA kexec functions
> > to ima_kexec.c."
> Will do.
> 
> > - Don't refer to a later patch, but explain the purpose here.  For
> > example, "Move ... , making them accessible to other archs."
> Sure.
> 
> > - The definition of "FDT_PROP_IMA_KEXEC_BUFFER" should be made as a
> > separate, prepartory patch, prior to the existing 1/4.  The resulting
> > code being moved in this patch (and similarly for 1/4) will be exactly
> > the same as the code being deleted.
> 
> Definition of FDT_PROP_IMA_KEXEC_BUFFER will be made as a preparatory 
> patch as you'd mentioned in the comments for [PATCH 1/4].
> 
> Will split [PATCH 2/4] as listed below:
> 
> PATCH #1: Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to 
> IMA, along with deleting them in arch/powerpc/kexec/ima.c

No, other than the comments above, this patch is fine.  It moves
ima_get_kexec_buffer() and ima_free_kexec_buffer() to ima_kexec.c.

Mimi


