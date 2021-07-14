Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B32F3C8B8D
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhGNTXw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 15:23:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhGNTXw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 15:23:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EJ3thW151543;
        Wed, 14 Jul 2021 15:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nRHnCM+7ey5o/Va1tRJCZxZIJcs/RcPprOFqqqWjffw=;
 b=pR+OjB+0L7nPzxLYC1r6sZ5T/tBkrPU+JNuuH0pDplklXWSemN64kxpks/8DmMKWlA0X
 sL+K7za1dGnFRhMklwEbld6m75vfJgWu2nf6HmQYGpmTgsFtJRhX0iPqZI6ADpQm6C0u
 U5148kYzY0hr2ySyUc4qlvpqth+UdESxCG3Or/Wy3YHDxfhimpttafaMH2Xhrqd/bvuK
 7w0Iu4Xih7UV5TPhAa54US2nQAGPX8JZEGOGJKbqGPad3osA0z4GH5SQYD0VzTpKnAX2
 zQLSg7pyOx/36c7rKzNApFAKuSI1pNF3P71EZ7WrX5Lig8qDweOaB7bfj+ZYw0Nkr8OU qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39sufykte8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 15:20:58 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16EJ490q156711;
        Wed, 14 Jul 2021 15:20:58 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39sufyktdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 15:20:58 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16EJDB85009458;
        Wed, 14 Jul 2021 19:20:55 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 39q2th9x3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 19:20:55 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16EJKrms34078978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 19:20:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E959F4C046;
        Wed, 14 Jul 2021 19:20:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C842D4C050;
        Wed, 14 Jul 2021 19:20:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.127.85])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Jul 2021 19:20:51 +0000 (GMT)
Message-ID: <46cba7f404f09c13a5a80606ee934b185660e567.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v8 3/3] Read keyid from the cert appended
 to the key file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 14 Jul 2021 15:20:50 -0400
In-Reply-To: <20210714181348.yjvfk5p5uxqarl2q@altlinux.org>
References: <20210712054448.2471236-1-vt@altlinux.org>
         <20210712054448.2471236-4-vt@altlinux.org>
         <2d54bb0340e2971234084db68cc00e27089388a8.camel@linux.ibm.com>
         <20210714181348.yjvfk5p5uxqarl2q@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AxocAvOJbrnADly9s7r1Nn1BQfs9-rp7
X-Proofpoint-ORIG-GUID: 90WuTfzmPkXi10VIBKtC5H0hSVWQ8TzU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_10:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-07-14 at 21:13 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Wed, Jul 14, 2021 at 12:16:57PM -0400, Mimi Zohar wrote:
> > On Mon, 2021-07-12 at 08:44 +0300, Vitaly Chikunov wrote:
> > > 
> > > @@ -43,26 +43,43 @@ cat > test-ca.conf <<- EOF
> > >  	basicConstraints=CA:TRUE
> > >  	subjectKeyIdentifier=hash
> > >  	authorityKeyIdentifier=keyid:always,issuer
> > > +
> > > +	[ skid ]
> > > +	basicConstraints=CA:TRUE
> > > +	subjectKeyIdentifier=12345678
> > > +	authorityKeyIdentifier=keyid:always,issuer
> > >  EOF
> > >  fi
> > 
> > On my system:
> > $ openssl version
> > OpenSSL 1.1.1g FIPS  21 Apr 2020
> > 
> > Not sure this has anything to do with the reason that "skid" is not
> > supported.   The resulting files are empty.
> > 
> > ls -lat *skid*
> > -rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.key
> > -rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.pub
> > 
> > - openssl pkey -in test-rsa1024.key -out test-rsa1024.pub -pubout
> > - openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509
> > -extensions skid -config test-ca.conf -newkey rsa:1024 -out test-
> > rsa1024_skid.cer -outform DER -keyout test-rsa1024_skid.key
> > Using configuration from test-ca.conf
> > Error Loading extension section skid   <===
> 
> Is it reproducible? Since multiple-distributions CI passed, I wonder
> what distro it is.

I'm running the tests locally on RHEL 8.4 and Fedora 34 rawhide
systems.  When generating the keys, the output is redirected to
/dev/null.   The end result is that the test is simply skipped.

sign_verify.test:
./gen-keys.sh >/dev/null 2>&1

[On Fedora:
$ openssl version
OpenSSL 1.1.1k  FIPS 25 Mar 2021]

Mimi

