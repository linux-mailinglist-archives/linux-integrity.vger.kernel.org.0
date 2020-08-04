Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0476423BF33
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 20:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHDSL5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 14:11:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725826AbgHDSL5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 14:11:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074I3Q19052181;
        Tue, 4 Aug 2020 14:11:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32q9sm5v7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 14:11:52 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 074I5JOG058694;
        Tue, 4 Aug 2020 14:11:52 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32q9sm5v72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 14:11:52 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074HoMn8016363;
        Tue, 4 Aug 2020 18:11:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 32n0183jeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 18:11:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 074IBlXQ26542426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 18:11:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0FF811C04A;
        Tue,  4 Aug 2020 18:11:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C94211C05C;
        Tue,  4 Aug 2020 18:11:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.44.248])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Aug 2020 18:11:45 +0000 (GMT)
Message-ID: <e2f9d32846f5fda89b138439b6cbec2c9dcfe643.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH v1 5/5] ima-evm-utils: travis: openssl
 gost engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Tue, 04 Aug 2020 14:11:44 -0400
In-Reply-To: <20200804144554.6y3c44popmu6nha7@altlinux.org>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
         <20200731182408.696931-6-zohar@linux.ibm.com>
         <70b421b26c7073dcc7d9b8f210ba2900ecf2b8d3.camel@linux.ibm.com>
         <20200804144554.6y3c44popmu6nha7@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_04:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040131
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-04 at 17:45 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Tue, Aug 04, 2020 at 08:05:31AM -0400, Mimi Zohar wrote:
> > The openssl version might not have gost openssl engine support.
> > Download from source, rebuild and install local version.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  .travis.yml                  | 10 ++++++++++
> >  tests/install-gost-engine.sh | 10 ++++++++++
> >  2 files changed, 20 insertions(+)
> >  create mode 100755 tests/install-gost-engine.sh
> > 
> > diff --git a/.travis.yml b/.travis.yml
> > index 11a827c02f0a..887f6bbea9b9 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -15,6 +15,13 @@ matrix:
> >     include:
> >       - env: TSS=ibmtss
> >       - env: TSS=tpm2-tss
> > +
> > +before_install:
> > +   - if [ "${SSL}" = "openssl" ]; then
> > +        ./tests/install-gost-engine.sh;
> > +        openssl version;
> > +     fi
> > +
> >  install:
> >     - if [ "${TSS}" = "tpm2-tss" ]; then
> >             sudo apt-get install lcov pandoc autoconf-archive liburiparser-dev;
> > @@ -30,6 +37,9 @@ install:
> >  script:
> >     - export LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib;
> >     - export PATH=$PATH:/usr/local/bin;
> > +   - if [ "${SSL}" = "openssl" ]; then
> > +        export OPENSSL_ENGINES="$OPENSSL_ENGINES:$PWD/engines/bin";
> 
> Should be `export OPENSSL_ENGINES=$PWD/engines/bin` since
> OPENSSL_ENGINES is not PATH-like variable, but just a path to engines
> dir.

Done, thanks.  Assuming there is nothing else, I'll release v1.3.1
tomorrow.

thanks!

Mimi

