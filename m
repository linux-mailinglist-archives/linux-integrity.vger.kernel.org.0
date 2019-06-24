Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F5F51BA1
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 21:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfFXTrh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jun 2019 15:47:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbfFXTrh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jun 2019 15:47:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OJlTFR117860
        for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2019 15:47:35 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tb3uuaurv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2019 15:47:34 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 24 Jun 2019 20:47:32 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Jun 2019 20:47:29 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5OJlSQ537814566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 19:47:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 445D542042;
        Mon, 24 Jun 2019 19:47:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4F3A42041;
        Mon, 24 Jun 2019 19:47:27 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jun 2019 19:47:27 +0000 (GMT)
Subject: Re: [PATCH v7 00/11] ima-evm-utils: Convert v2 signatures from RSA
 to EVP_PKEY API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:47:27 -0400
In-Reply-To: <20190624192349.gdp2xbe5c6etaw6v@altlinux.org>
References: <20190623090027.11852-1-vt@altlinux.org>
         <1561387352.4340.20.camel@linux.ibm.com>
         <20190624161638.xz6ebfvxzilh2gew@altlinux.org>
         <1561403393.4340.58.camel@linux.ibm.com>
         <20190624192349.gdp2xbe5c6etaw6v@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062419-0020-0000-0000-0000034D0002
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062419-0021-0000-0000-000021A06B2D
Message-Id: <1561405647.4340.63.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240158
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-06-24 at 22:23 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Mon, Jun 24, 2019 at 03:09:53PM -0400, Mimi Zohar wrote:
> > On Mon, 2019-06-24 at 19:16 +0300, Vitaly Chikunov wrote:
> > > On Mon, Jun 24, 2019 at 10:42:32AM -0400, Mimi Zohar wrote:
> > > > On Sun, 2019-06-23 at 12:00 +0300, Vitaly Chikunov wrote:
> > > > > Convert sign v2 from RSA API (with manual formatting PKCS1) to more generic
> > > > > EVP_PKEY API, allowing to generate more types of OpenSSL supported signatures.
> > > > > This is done to enable EC-RDSA signatures, which are already supported in the
> > > > > Kernel. With some small fixes.
> > > > > 
> > > > > All patches tested on x86_64 to not break anything.
> > > > > 
> > > > > Changes since v6:
> > > > > - Remove "Make sure sig buffer is always MAX_SIGNATURE_SIZE" commit. Instead,
> > > > >   change assumption of sign_hash_v2() about @sig size.
> > > > 
> > > > With and without this change, the sha family is working properly, but
> > > > with this patch set, I'm now seeing "sign_hash_v2: signing failed:
> > > > (invalid digest)" for gost/streebog.  Previously it worked.
> > > 
> > > Sounds strange. For me it's working good for streebog now and then.
> > > 
> > >   = Testing algo gost2012_256-A hash streebog256 =
> > >   test.txt: verification is OK
> > >   ...
> > > 
> > > Maybe somehow your test env is getting broken?
> > > 
> > > I test on Debian 9, manually compiled openssl and then gost-engine
> > > from git. Env is like this:
> > > 
> > >   PATH=$HOME/src/openssl/apps:$HOME/src/ima-evm-utils/src/.libs:$PATH
> > >   LD_LIBRARY_PATH=$HOME/src/openssl:$HOME/src/ima-evm-utils/src/.libs
> > >   OPENSSL_CONF=$HOME/src/gost-engine/build/openssl.conf
> > >   OPENSSL_ENGINES=$HOME/src/gost-engine/build/bin
> > > 
> > > ima-evm-utils is ./configure'd with
> > > 
> > >   export OPENSSL_LIBS="-L$HOME/src/openssl -lssl -lcrypto"
> > > 
> > > and then make'd without install, and test run.
> > 
> > Ok.  I'm using a version, which I built when you first sent the
> > patches for the crypto engine support.
> 
> Did you mean you try to make RSA signature with Streebog hashes? This
> shouldn't work, as intended. Streebog hash only should be used with
> EC-RDSA signatures (or gost2012_{256,512} in terms of OpenSSL).
> 
> If it worked before this is strange. It should not. What patchset
> version it was?

No, I'm saying that I built both openssl and the gost engine a while
ago.  There's been some gost engine updates since then, which are
dependent on a newer version of openssl.  So I'll need to rebuild both
openssl and the gost engine in order to re-test.

Mimi

