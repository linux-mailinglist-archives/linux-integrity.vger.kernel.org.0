Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8F8243EB7
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 20:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMSP4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 14:15:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27280 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgHMSP4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:15:56 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DI3TkK149415;
        Thu, 13 Aug 2020 14:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=f3d7L3Z8TozRrHr7LlsJHO/eZY3dSbjtP9JU2XR9TIc=;
 b=exHGkGZ0DyHm9tGd7fQL7KZ9KD3EPUxljnv3ULC1gcPlgmpuVoVHsFJXa8ANykPivaCu
 slK2f2TNVdgrHYaraYVQf83Kp1cayJTbfv0PtVIdulUlRdHAc16HcvmGqBn172zexyuf
 pXVgKV51cfQnPvjor7OJbx7HHx3ua7zbbVwZBFviqebfKNtbtmfC9ECXVa75gV2skVNc
 eJ56jurnTS1owKC/8YdQUoxyiwFJ6qi/GUIX7/DoP3AZ6vmUJ0iOVetZDbKZcDcj4UO1
 2fgzQbUuJJhUyN71nuOzHEP9AYQQrVmg8ASXs02syTRrZgHZBxqP9lTLQpeHyPIkI4v7 Dg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32t93tgt2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 14:15:51 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DIC7q4002770;
        Thu, 13 Aug 2020 18:15:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 32skp83jwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 18:15:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DIEJ7N60031342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 18:14:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ECB5A4040;
        Thu, 13 Aug 2020 18:15:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3748AA404D;
        Thu, 13 Aug 2020 18:15:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.122.169])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Aug 2020 18:15:45 +0000 (GMT)
Message-ID: <93793b105fc2945435e3c26a6f74eee28ae03e0f.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org
Date:   Thu, 13 Aug 2020 14:15:45 -0400
In-Reply-To: <20200812130548.GB4994@gacrux.arch.suse.de>
References: <20200803130755.GA30440@dell5510>
         <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
         <20200803164635.GB4914@dell5510>
         <bc771e16d4afd3454dea37537f759343452c6446.camel@linux.ibm.com>
         <20200804072234.GA4337@dell5510> <20200804075453.GA7285@dell5510>
         <980a1c491dcc03606635cdddce8b19e7a2e041c5.camel@linux.ibm.com>
         <20200805094215.GA32709@dell5510> <20200811173303.GA31322@dell5510>
         <146ee0acc5d5f619b6b19ae2a3bcb6a66cacce32.camel@linux.ibm.com>
         <20200812130548.GB4994@gacrux.arch.suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_15:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-12 at 15:05 +0200, Petr Vorel wrote:
> Hi Mimi, Vitaly,
> 
> ...
> > > I prototype docker based Travis [1] (still WIP). It tests various distros,
> > > including cross-compilation, using also clang, even one build with musl (Alpine
> > > distro). But there are many failures.
> > > The biggest problem is with ibmswtpm2 [2], which contain tpm_server binary. This
> > > project is not packaged in distros, compiles only with gcc (no clang, I tested
> > > versions 1332 and 1637) and ignore CFLAGS and LDFLAGS settings. It doesn't even
> > > have git repository (the one on sourceforge is empty).
> > > We could simply patch this file, but I'm not going to do it.
> > > I guess I just skip tpm_server dependency for all non-native projects.
> > > I also need always install gcc even clang is going to be used due tpm_server.
> > Agreed, getting docker/travis working is independent of tpm_server. 
> > Without a software TPM, the boot_aggregate test will be skipped.  For
> > now, until we can straighten this out,  I would modify "make check" to
> > run the other tests (e.g. make check TESTS="ima_hash.test
> > sign_verify.test").
> Yes, specifying tests to be tested is an option. But if skipping the compilation
> for non-native builds works (e.g. tests which don't specify $VARIANT), I'd go
> this way. That help us not having to remember to update tests for non-native
> builds (once the new ones are added).

Sure.  libtmps/swtpm could be installed in lieu of the ibmswtpm2. 
Sample directions for using it are here: 
https://github.com/stefanberger/swtpm/wiki/Using-the-IBM-TSS-with-swtpm
.

thanks,

Mimi

