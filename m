Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37A523B9A2
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 13:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgHDLg1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 07:36:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729705AbgHDLg0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 07:36:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074BXRn4089041;
        Tue, 4 Aug 2020 07:36:02 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32q6msrgbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 07:36:02 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074BQDQo000756;
        Tue, 4 Aug 2020 11:36:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 32n0189ykc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 11:35:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 074BYVLn19071348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 11:34:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8479F52054;
        Tue,  4 Aug 2020 11:35:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.7.87])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0950952050;
        Tue,  4 Aug 2020 11:35:55 +0000 (GMT)
Message-ID: <a07ed4a73b51ba27cfc2d4b4fe1b11f083748e21.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>
Date:   Tue, 04 Aug 2020 07:35:55 -0400
In-Reply-To: <1595820339.32688.26.camel@HansenPartnership.com>
References: <20200722155739.26957-1-James.Bottomley@HansenPartnership.com>
         <20200722155739.26957-2-James.Bottomley@HansenPartnership.com>
         <20200724065745.GB1871046@linux.intel.com>
         <1595820339.32688.26.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_03:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040086
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On Sun, 2020-07-26 at 20:25 -0700, James Bottomley wrote:
> On Fri, 2020-07-24 at 09:57 +0300, Jarkko Sakkinen wrote:
> > On Wed, Jul 22, 2020 at 08:57:39AM -0700, James Bottomley wrote:
> > > use macro magic to create sysfs per hash groups with 24 PCR files
> > > in
> > 
> > 'Use'
> > 
> > Please, just say what the patch does in plain English and dust the
> > magic away.
> 
> The reason for the macro magic comment is that there are 3 checkpatch
> errors and one warning from this, all spurious, because checkpatch
> doesn't understand the syntax of macros that create macros.
> 
> > > them one for each possible agile hash of the TPM.  The files are
> >                                                    ~~
> > 
> > I'd prefer a single space.
> 
> It's still listed in the style guides as best practice for monospaced
> fonts, but at this point I've lost the will to care about it.
> 
> > > plugged in to a read function which is TPM version agnostic, so
> > > this works also for TPM 1.2 although the hash is only sha1 in that
> > > case. For every hash the TPM supports, a group named pcr-<hash> is
> > > created and each of the PCR read files placed under it.
> > 
> > Yeah, the commit message is missing the statement what it does and
> > goes straight away rationalizing "macro magic".
> 
> OK so how about
> 
> ---
> Create sysfs per hash groups with 24 PCR files in them one group, named
> pcr-<hash>, for each agile hash of the TPM.  The files are plugged in
> to a PCR read function which is TPM version agnostic, so this works
> also for TPM 1.2 although the hash is only sha1 in that case.
> 
> Note: the macros used to create the hashes emit spurious checkpatch
> warnings.  Do not try to "fix" them as checkpatch recommends otherwise
> they'll break.
> ---

Any chance of getting this patch at least queued to be upstreamed?

thanks,

Mimi

