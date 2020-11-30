Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB552C87C0
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Nov 2020 16:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgK3PV6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 10:21:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48078 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728051AbgK3PV5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 10:21:57 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUFL5CB159015;
        Mon, 30 Nov 2020 10:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=u/SrLUxJR1tabV7LVrQzxZEtog8GgMfWQ5rp9VzT36U=;
 b=IF36TU4VBYy5Fa0zBNruZ6ucYsqoS777R7OhknNe5fTfp+nmPjDPlhPrvWMJEAWXAX7A
 h3KAyj/dUVrS740PsD2Ni0yHAMWUcwtIoWzzwOMBrxXujwqM8sbI8E3fpN/rnZEF15gN
 V4W5+fa5BPvXd/Y3N0rXRYsnzMaXmBAXVH0zwwkjgUQFNHi+6jukYu7LNOJF7T4/zEpa
 1k7kvgUeGu2ARrd0ITEDIDfJdcFrtcoE7RzwgpuKqb45lvNh5UypcWQgHj7UpYXbD1Z1
 /ShhGYdWKK7gW+hClrMqxdtgBY9kt3M5RajtKBtsbrNHn8Ki2qRx8bSYPWworPl3YPDT BA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3553a7r01a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 10:21:08 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AUFKsx6001439;
        Mon, 30 Nov 2020 15:21:07 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 353e6825fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 15:21:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AUFL4945636840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 15:21:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2AA052063;
        Mon, 30 Nov 2020 15:21:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.59.46])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6A39652057;
        Mon, 30 Nov 2020 15:21:03 +0000 (GMT)
Message-ID: <ee9428f8a4259a86ad331ff169f98c4e8e090d6d.camel@linux.ibm.com>
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Greg KH <greg@kroah.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Date:   Mon, 30 Nov 2020 10:21:02 -0500
In-Reply-To: <X8Sq6VPMtOxPAi3N@kroah.com>
References: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
         <X8Sq6VPMtOxPAi3N@kroah.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_05:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1011 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300094
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-11-30 at 09:18 +0100, Greg KH wrote:
> On Sun, Nov 29, 2020 at 02:30:21PM -0800, James Bottomley wrote:
> > Cc to linux-api to get an opinion on two issues.  First the background:
> > 
> > We've had a fairly extensive discussion over on linux-integrity and
> > iterated to the conclusion that the kernel does need to export TPM 2.0
> > PCR values for use by a variety of userspace integrity programmes
> > including early boot.  The principle clinching argument seems to be
> > that these values are required by non-root systems, but in a default
> > Linux set up the packet marshalled communication device: /dev/tpmrm0,
> > is by default only usable by root.  Historically, TPM 1.2 exported
> > these values via sysfs in a single file containing all 24 values:
> > 
> >   /sys/class/tpm/tpm0/pcrs
> > 
> > with the format
> > 
> >   PCR-00: 7D 29 CB 08 0C 0F C4 16 7A 0E 9A F7 C6 D3 97 CD C1 21 A7 69 
> >   PCR-01: 9C B6 79 4C E4 4B 62 97 4C AB 55 13 1A 2F 7E AE 09 B3 30 BE 
> >   ...
> 
> As you know, this breaks the "one value per file" for sysfs, so please,
> do not add more files that do this.
> 
> > TPM 2.0 adds more complexity: because of it's "agile" format, each TPM
> > 2.0 is required to support a set of hashes (of which at least sha1 and
> > sha256 are required but quite a few TPM 2.0s have at least two or
> > three more) and maintain 24 PCR registers for each supported hash.
> > The current patch exports each PCR bank under the directory
> > 
> >   /sys/class/tpm/tpm0/pcr-<hash>/<bank>
> > 
> > So the sha256 bank value of PCR 7 can be obtained as
> > 
> >   cat /sys/class/tpm/tpm0/pcr-sha256/7
> >   2ED93F199692DC6788EFA6A1FE74514AB9760B2A6CEEAEF6C808C13E4ABB0D42
> > 
> > And the output is a single non-space separated ascii hex value of the
> > hash.
> > 
> > The issues we'd like input on are:
> > 
> >  1. Should this be in sysfs or securityfs?
> 
> If you want to use sysfs, use one value per file please.
> 
> >   2. Should we export the values as one value per file (current patch)
> >      or as a binary blob of all 24?
> 
> Binary sysfs files are for "pass-through" mode where the kernel is not
> parsing/manipulating the data at all.  Do these values come straight
> from the hardware?  If so, sure, use a binary blob.  If not, then no, do
> not use that in sysfs as sysfs is to be in text format.

The data is coming from the hardware, but not the result of a single
TPM command.  Each TPM bank PCR has to be queried individually.  The
question is whether the result should be exported separately (via
sysfs) or aggregated as a single binary blob (via securityfs).

thanks,

Mimi

