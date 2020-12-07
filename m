Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFDB2D1439
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Dec 2020 16:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgLGO7g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Dec 2020 09:59:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgLGO7g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Dec 2020 09:59:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B7EbJNs020191;
        Mon, 7 Dec 2020 09:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6b/b5Dxe605BC5GsozJi2jrq8Z2Th2EsN7f8+8G/lm4=;
 b=g4rAs4oqnDgqpOwA0rAY9SsZ9PrfQhbHu4niNfOCs8IwbWotJykuqzJMMdLyVQuOKnDc
 WU9npB/Im5C8FmnWEAKtcygzPWeUDlqe05mBomL3LlNwgQRm1Ka+49xGCx7bcUfOWTJ6
 KzXjKODkFlE2AOimM69/O6yIE1l48BDeyAiC0MfrQxUudRxeCnT8RrZ24xkK1+4+S027
 qh7xGl6tfDCP1cMBlj/OSsgZzj4QbXSAG+bX9+qYdOYAOwVIIO9wqUwxivDJnL3b+g4Z
 1jHVGNSFmobt/I8uCCASgM61Kl6mmB1Fzs5SHVwkq1vpsZTpYxmb+E/ABQfvkGQNpHyn 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359p0dsbts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 09:58:07 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B7EbALl019040;
        Mon, 7 Dec 2020 09:58:06 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359p0dsbst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 09:58:06 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B7EqRFq020474;
        Mon, 7 Dec 2020 14:58:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3581fhjk8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 14:58:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B7Ew1R364815572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 14:58:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3649DA4064;
        Mon,  7 Dec 2020 14:58:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ED88A4054;
        Mon,  7 Dec 2020 14:57:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.115.213])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Dec 2020 14:57:55 +0000 (GMT)
Message-ID: <49408f07b91685e058f94844e73c753bb2033d35.camel@linux.ibm.com>
Subject: Re: [PATCH v10 7/8] powerpc: Move arch_ima_add_kexec_buffer to ima
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     robh@kernel.org, gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Date:   Mon, 07 Dec 2020 09:57:54 -0500
In-Reply-To: <0f60b35e-eff6-20c6-363d-82f0b10a1c1f@linux.microsoft.com>
References: <20201204195149.611-1-nramas@linux.microsoft.com>
         <20201204195149.611-8-nramas@linux.microsoft.com>
         <87k0twlytt.fsf@manicouagan.localdomain>
         <0f60b35e-eff6-20c6-363d-82f0b10a1c1f@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_11:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070094
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-12-06 at 18:03 -0800, Lakshmi Ramasubramanian wrote:
> On 12/5/20 1:36 PM, Thiago Jung Bauermann wrote:
> > 
> > Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
> >> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> >> index 4d354593aecf..5263dafe8f4d 100644
> >> --- a/security/integrity/ima/ima_kexec.c
> >> +++ b/security/integrity/ima/ima_kexec.c
> >> @@ -74,6 +74,28 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
> >>   	return ret;
> >>   }
> >>   
> >> +/**
> >> + * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
> >> + *
> >> + * @image: kimage struct to set IMA buffer data
> >> + * @load_addr: Starting address where IMA buffer is loaded at
> >> + * @size: Number of bytes in the IMA buffer
> >> + *
> >> + * Architectures should use this function to pass on the IMA buffer
> >> + * information to the next kernel.
> >> + *
> >> + * Return: 0 on success, negative errno on error.
> >> + */
> >> +static int arch_ima_add_kexec_buffer(struct kimage *image,
> >> +				     unsigned long load_addr,
> >> +				     size_t size)
> >> +{
> >> +	image->arch.ima_buffer_addr = load_addr;
> >> +	image->arch.ima_buffer_size = size;
> >> +
> >> +	return 0;
> >> +}
> >> +
> > 
> > Both powerpc and arm64 use the definition above for
> > arch_ima_add_kexec_buffer(), so it makes sense to share them as you do
> > in this patch. This file isn't the best one to put arch-specific code
> > which happens to be identical among architectures, but I can't think of
> > somewhere else to put it.
> > 
> > For now this isn't an issue since powerpc and arm64 are the only arches
> > implementing tihs feature. If a third arch implemented it and also used
> > the same function definition as above, it wouldn't be an issue either so
> > perhaps this is good enough for the time being? :-)
> 
> If Mimi doesn't have any objection, I'll leave this function in this 
> file. The other option is to move this function also to 
> "drivers/of/kexec.c".
> 
> Please let me know.

Defining arch_ima_add_kexec_buffer() function, as static, here in
ima_kexec.c is weird.  For this reason, I specifically asked Thiago to
look at it.  Thanks, Thiago, for looking and reviewing the rest of the
patch set.  Duplicating the code or defining it in drivers/of, doesn't
make sense either.  As Thiago suggested, define it here until there is
a reason to move it.

thanks,

Mimi

