Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36BC2617B2
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 19:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbgIHRju (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 13:39:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731684AbgIHQOM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088E2lYR090675;
        Tue, 8 Sep 2020 10:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=qvtY3efdmKTycDkCx+zMSmoSNBQYkw3/GROUiRKGaAk=;
 b=DtSotS3N2vNLQGr0szPGdp1w7Lox58FSAPolXeZjEjmYTcqAovLvnA8S30qKm7keSVK1
 46B1ujBG+IMiBxRqHK7zpVHVQuV4I145HZuuE7qMYWk0VAIH9RCbEn0JrFthAgm6GoAn
 vkS8wf/uo+FiZEHRWnxl55OMvtYy3Pve/NOybUPYG4IvJS+0vkxkvRGzD0k4iUY8ZWhp
 aKHIJTVkgQEeHtiFrpUZgEVJ/GsQGYIU+uxiPeiBxSoZXx8P2XFJBdNGMdgB8xrAmDel
 o51sUJPzhVfrZF8TbsiuAQ5o1yQr8xC3RY3+bqSbcraTV5x1YTGSfm8dzdZUzwHkF2Y5 sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33eb9886pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 10:03:35 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 088E32Y6092121;
        Tue, 8 Sep 2020 10:03:35 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33eb9886n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 10:03:35 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 088E1cVf007112;
        Tue, 8 Sep 2020 14:03:32 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 33c2a8a53w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 14:03:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 088E3UKl13369646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Sep 2020 14:03:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF0A9A405C;
        Tue,  8 Sep 2020 14:03:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4DBCA405F;
        Tue,  8 Sep 2020 14:03:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.24.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Sep 2020 14:03:25 +0000 (GMT)
Message-ID: <d405bab0d262b32fd16e85444791b6c49d820aa2.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 00/30] ima: Introduce IMA namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Luke Hinds <lhinds@redhat.com>, "Dr. Greg" <greg@enjellic.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        krzysztof.struczynski@huawei.com, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, stefanb@linux.vnet.ibm.com,
        sunyuqiong1988@gmail.com, mkayaalp@cs.binghamton.edu,
        dmitry.kasatkin@gmail.com, "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>, christian@brauner.io,
        silviu.vlasceanu@huawei.com, roberto.sassu@huawei.com,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, luto@amacapital.net,
        jannh@google.com, nick.dusek@gmail.com
Date:   Tue, 08 Sep 2020 10:03:24 -0400
In-Reply-To: <CAKrSGQR3Pw=Rad2RgUuCHqr0r2Nc6x2nLoo2cVAkD+_8Vbmd7A@mail.gmail.com>
References: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
         <20200818164943.va3um7toztazcfud@wittgenstein>
         <d77a6cd783319702fddd06783cb84fdeb86210a6.camel@linux.ibm.com>
         <20200906171413.GA8305@wind.enjellic.com>
         <CAKrSGQR3Pw=Rad2RgUuCHqr0r2Nc6x2nLoo2cVAkD+_8Vbmd7A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_07:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-09-07 at 12:50 +0100, Luke Hinds wrote:
> > Candidly, given the politics of security technology being viewed as
> > 'constraining' user rights, I think that a lot of forthcoming security
> > technology may end up being out of tree moving forward.
> > 
> 
> I think it's prudent to look forward and plan diligently, but I would
> not want perfect to be the enemy of good.

Agreed.  This isn't an abstract problem, but one that has already come
up and, hopefully, has been addressed appropriately.

> 
> I approach this more from a user's perspective. We are using IMA in 
> https://keylime.dev to measure a host and would like to measure
> within a container too. It's the most common request we hear from our
> users.
> 
> Perhaps we all collaborate on a proposal extending Stefans work here:
> https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerati
> ons
> 
> I have seen around 3-4 patches now get submitted, so work has been
> done before, and as above, users are present too. We could then have
> some consensus on how this should look and later patches might have
> more success at landing.
> 
> Would anyone be interested in this and have recommendations on how we
> could approach this?

When Roberto Sassu and Krzysztof Struczynski contacted me about the
status of Stefan Berger's patch set, based on Yuqiong Sun's work, I was
under the impression that they would be rebasing it on the latest
kernel and going forward from there.   Obviously things changed.  I
pointed out to them resolving the "IMA namespacing" issue would be the
first thing that needs to be addressed.  So here we are.

Definitely, let's have this discussion.

Mimi

