Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BBE23BB19
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgHDNYG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 09:24:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728343AbgHDNYG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 09:24:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074DKWxr054535;
        Tue, 4 Aug 2020 09:24:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32q6msusjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 09:24:01 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 074DKw7g057227;
        Tue, 4 Aug 2020 09:24:00 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32q6msusfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 09:23:59 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074DKLfD011588;
        Tue, 4 Aug 2020 13:23:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 32n0183bfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 13:23:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 074DNsO725297364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 13:23:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0BD75204F;
        Tue,  4 Aug 2020 13:23:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.7.87])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D7D0852050;
        Tue,  4 Aug 2020 13:23:52 +0000 (GMT)
Message-ID: <980a1c491dcc03606635cdddce8b19e7a2e041c5.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Tue, 04 Aug 2020 09:23:51 -0400
In-Reply-To: <20200804075453.GA7285@dell5510>
References: <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
         <20200731204044.GC27841@dell5510>
         <20200731210653.p5m4efy52melqwgs@altlinux.org>
         <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
         <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
         <20200803130755.GA30440@dell5510>
         <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
         <20200803164635.GB4914@dell5510>
         <bc771e16d4afd3454dea37537f759343452c6446.camel@linux.ibm.com>
         <20200804072234.GA4337@dell5510> <20200804075453.GA7285@dell5510>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_04:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040097
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr, Vitaly,

On Tue, 2020-08-04 at 09:54 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> > ...
> > > I left off the list TPM 2.0 --pcr support, but the kernel code for
> > > exporting the sysfs TPM 2.0 pcrs hasn't been upstreamed yet.   I guess
> > > we should wait for that to be upstreamed or at least queued to be
> > > upstreamed.
> > OK, we have to wait. BTW is the patch somewhere on ML? Is it part of this
> > pathset https://patchwork.kernel.org/cover/11656949/ ?
> Oh, that's for ima_evm_utils. I meant patchset for kernel space.

"[PATCH v3 1/1] tpm: add sysfs exports for all banks of PCR registers"
was posted here on the linux-integrity mailing list[1].  It's important
to get this patch upstreamed, but I think the PCR file format is useful
on its own.  For this reason, I'm going to backtrack and include it in
1.3.1.

I've posted a new version of "travis: openssl gost engine" addressing
the branch version and lack of an install target.   It assumes that
openssl was built with engine support and builds the gost engine
support from the git repo.  The environment variable is set, but has
not been tested.

Everything, including this change, should now be in the next-testing
branch.

thanks,

Mimi

[1] message-id: 
20200722155739.26957-2-James.Bottomley@HansenPartnership.com

