Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4403347D5ED
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Dec 2021 18:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhLVRnJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Dec 2021 12:43:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232852AbhLVRnJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Dec 2021 12:43:09 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMH7pAF015788;
        Wed, 22 Dec 2021 17:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=XOgqG8lAXRoFUzxHxr5Y0YBKcbRWJ2nHy7srCVyBNIk=;
 b=d7zGVZrR7n6QgGdsaiI/Hb5vdyZL0JiOeP9JvelA6tiot3uSpyKtx2YsEHj7ojsCti2D
 arhC48mYR0GKPBEmeygfj6Lcl6YHmr2YlV291UMUGjCF2z82HCIWQZL2ROOoWfydO7sZ
 bz5E1SLrxoMLDbQSaR68FCpn++0Hg/cBTw7MbEgnkmAh8BMT9BSglcx0Ycl3v99b6FOP
 ddpDOUqv8JPQ+mQO/qGHa+jS4eSF7KrG4VXgqnf3/iWt0gx8fRIb7z/eUoPUkDTYicjU
 Io/53XouBdXTgMZ1hrZq2jEPQBK4sNRZVHpdmIW4vd/K0NVBLJ2QfBHlek5qal8G2cxh 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d3eu0nk5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 17:42:50 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BMHKmRn006623;
        Wed, 22 Dec 2021 17:42:49 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d3eu0nk5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 17:42:49 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BMHX04m029574;
        Wed, 22 Dec 2021 17:42:48 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3d179a71dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 17:42:47 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BMHgjHo44761554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 17:42:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50813AE04D;
        Wed, 22 Dec 2021 17:42:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01C4FAE055;
        Wed, 22 Dec 2021 17:42:44 +0000 (GMT)
Received: from sig-9-65-92-34.ibm.com (unknown [9.65.92.34])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Dec 2021 17:42:43 +0000 (GMT)
Message-ID: <052995518e70c115ce3d49069a3b144de8733bb4.camel@linux.ibm.com>
Subject: Re: [PATCH v2] Instantiate key with user-provided decrypted data.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Yael Tiomkin <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko@kernel.org>, corbet@lwn.net,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Date:   Wed, 22 Dec 2021 12:42:43 -0500
In-Reply-To: <CAKoutNvhYYiKgCLFFqzczuT444TraMhmEhzFwC7u42ALTdSqaQ@mail.gmail.com>
References: <20211213192030.125091-1-yaelt@google.com>
         <ec2ec0a9a7ba1adc6e54bbf7051a83ba90a39c0b.camel@linux.ibm.com>
         <CAKoutNvhYYiKgCLFFqzczuT444TraMhmEhzFwC7u42ALTdSqaQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AszAQ6hxabwWZbjFdnyTG7lBZgFqvNkS
X-Proofpoint-ORIG-GUID: iryLD8G_3gDyQvTeUzpvZTesKcHWZPJf
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_07,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-12-22 at 11:31 -0500, Yael Tiomkin wrote:
> On Tue, Dec 14, 2021 at 7:37 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > Hi Yael,
> >
> > On Mon, 2021-12-13 at 14:20 -0500, Yael Tiomkin wrote:
> > > The encrypted.c class supports instantiation of encrypted keys with
> > > either an already-encrypted key material, or by generating new key
> > > material based on random numbers. To support encryption of
> > > user-provided decrypted data, this patch defines a new datablob
> > > format: [<format>] <master-key name> <decrypted data length>
> > > <decrypted data>.
> > >
> > > Signed-off-by: Yael Tiomkin <yaelt@google.com>
> >
> > Other than the comment below,
> >     Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >
> > Could you also provide an LTP test for defining, exporting, and loading
> > an encrypted key based on user provided key data?
> >
> > thanks,
> >
> > Mimi
> >
> > > ---
> >
> > > @@ -303,6 +306,16 @@ Load an encrypted key "evm" from saved blob::
> > >      82dbbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e0
> > >      24717c64 5972dcb82ab2dde83376d82b2e3c09ffc
> > >
> > > +Instantiate an encrypted key "evm" using user-provided decrypted data::
> > > +
> > > +    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm.blob`" @u
> > > +    794890253
> >
> > The existing references to "evm.blob" refer to the encrypted key data.
> > Here "evm.blob" is unencrypted data.  Perhaps name it something like
> > "evm.user-provided-data" data.
> >
> > > +
> > > +    $ keyctl print 794890253
> > > +    default user:kmk 32 2375725ad57798846a9bbd240de8906f006e66c03af53b1b382d
> > > +    bbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e0247
> > > +    17c64 5972dcb82ab2dde83376d82b2e3c09ffc
> > > +
> >
> 
> Hi Mimi,
> 
> I have posted the ltp test:
> https://lore.kernel.org/all/20211221023721.129689-1-yaelt@google.com/
> 
> I will update the documentation per your suggestion.

Please also prefix the patch title (Subject line) with "KEYS:
encrypted:" and remove the trailing period.

thanks,

Mimi

