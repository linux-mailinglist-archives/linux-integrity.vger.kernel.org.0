Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E58242249
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Aug 2020 00:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgHKWFM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Aug 2020 18:05:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgHKWFM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Aug 2020 18:05:12 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07BM3AXp091807;
        Tue, 11 Aug 2020 18:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=C1fJXzTK3pM3YtdxAbKVFwfTOTxp5xrKSM1JE++A/Ik=;
 b=fP9SK9LDRHMDOt9AFFXr5yOk3MOWppgSmBTbLGrM0E6c8OvIedu2gxOdK8S+aCMCAuNL
 DzOCLf/4DxT1rVivET+8RmQnizCLksYqglXaNTaUESOIyzK+GOj+8485j+y7eWjDnU8M
 q8AYj/4qMJOWvnTh9Al1LZWFAwoP+jHM83cYSLX+oChB+Yax/BmfElLA5wvUJ6O+0ABg
 oFYTDDND8AnGmIjLJhlu83yH0XrnIK2e9RpEsWXEDF7YJXLIT7ob5Vw3dFlpqFQ7mSZE
 kO81uw0Ad38YEp08R5Bc0WgAUkZZbzp39h7Nwn44FS1wFRaNofqSOuI2o9EMGMsc59Ge 4g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32sras8g31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 18:05:05 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07BLuLvW001618;
        Tue, 11 Aug 2020 22:05:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 32skp83s7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 22:05:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07BM51Kn30605806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 22:05:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB2AF42042;
        Tue, 11 Aug 2020 22:05:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1443942047;
        Tue, 11 Aug 2020 22:05:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.72.229])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Aug 2020 22:04:59 +0000 (GMT)
Message-ID: <146ee0acc5d5f619b6b19ae2a3bcb6a66cacce32.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org
Date:   Tue, 11 Aug 2020 18:04:58 -0400
In-Reply-To: <20200811173303.GA31322@dell5510>
References: <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
         <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
         <20200803130755.GA30440@dell5510>
         <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
         <20200803164635.GB4914@dell5510>
         <bc771e16d4afd3454dea37537f759343452c6446.camel@linux.ibm.com>
         <20200804072234.GA4337@dell5510> <20200804075453.GA7285@dell5510>
         <980a1c491dcc03606635cdddce8b19e7a2e041c5.camel@linux.ibm.com>
         <20200805094215.GA32709@dell5510> <20200811173303.GA31322@dell5510>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_15:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110158
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-11 at 19:33 +0200, Petr Vorel wrote:
> Hi Mimi, Vitaly,
> 
> > > Everything, including this change, should now be in the next-testing
> > > branch.
> > Nice, thanks! Tested:
> > https://travis-ci.org/github/pevik/ima-evm-utils
> > I hope I'll have time for docker based travis patch next week.
> 
> I prototype docker based Travis [1] (still WIP). It tests various distros,
> including cross-compilation, using also clang, even one build with musl (Alpine
> distro). But there are many failures.
> 
> The biggest problem is with ibmswtpm2 [2], which contain tpm_server binary. This
> project is not packaged in distros, compiles only with gcc (no clang, I tested
> versions 1332 and 1637) and ignore CFLAGS and LDFLAGS settings. It doesn't even
> have git repository (the one on sourceforge is empty).
> We could simply patch this file, but I'm not going to do it.
> I guess I just skip tpm_server dependency for all non-native projects.
> I also need always install gcc even clang is going to be used due tpm_server.

Agreed, getting docker/travis working is independent of tpm_server. 
Without a software TPM, the boot_aggregate test will be skipped.  For
now, until we can straighten this out,  I would modify "make check" to
run the other tests (e.g. make check TESTS="ima_hash.test
sign_verify.test").

thanks,

Mimi

> 
> It also find bug in m4/manpage-docbook-xsl.m4 for Alpine, found custom xml
> catalog, but value is not redirected into the variable.
> 
> Kind regards,
> Petr
> 
> [1] https://travis-ci.org/github/pevik/ima-evm-utils/builds/716990585
> [2] https://sourceforge.net/projects/ibmswtpm2/
> 


