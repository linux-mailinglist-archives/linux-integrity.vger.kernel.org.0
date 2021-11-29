Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6077F461C77
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 18:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347029AbhK2RLS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 12:11:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1347147AbhK2RJS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 12:09:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATGHWXM003331;
        Mon, 29 Nov 2021 17:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yc5kWkkyRApb2Rb2ytJCmjxRn8OdoD8YkqP5MFJObd8=;
 b=Oe0m6U7kK7VXG9Mfc3TOfbIM4nRW0/cueESreILe4hPEcnwSQY1byisTvAHnIUcNMrq5
 iA4DEcVcBY9bEoe0WY9q80s0KtSnXsPhl0OJJzZgMtBT884mEZQ/hCyqtZHTwzSN7fNj
 oD/jAIW75SPexQ+tHwhJ8+jwFI1P6L4Jkp1RTXi3UPCyOgThqBgY7D62ebFomnJkR3FH
 VXNfxLnOs/qCMitLVoM1HV/SYroLTDb5i33ddsXXzd+FEhTN7VaDvW8AIW1sEi731lYc
 Bepo3BH80y2COHcpNYVF6B0oM2yG56UXOmp3azDnRGX8XOq4FzTOUxYPhsgabnFRwvIT Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cn28p970k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 17:05:47 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATGId7Y007479;
        Mon, 29 Nov 2021 17:05:47 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cn28p9706-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 17:05:47 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATGvTbU031053;
        Mon, 29 Nov 2021 17:05:46 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 3ckcaapwvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 17:05:45 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATH4UhA51577118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 17:04:30 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F151B124055;
        Mon, 29 Nov 2021 17:04:29 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E4B012406C;
        Mon, 29 Nov 2021 17:04:29 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 17:04:29 +0000 (GMT)
Message-ID: <c73dd2cc-7915-9343-5ad0-e53c762e29a3@linux.ibm.com>
Date:   Mon, 29 Nov 2021 12:04:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
 <20211129045834.GB20606@mail.hallyn.com>
 <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
 <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
 <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
 <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
 <afee2f0483271a6cdb1bc7b48b819a3ca2c4ceda.camel@HansenPartnership.com>
 <20211129153539.GA26325@mail.hallyn.com>
 <20211129161650.dtcvh2ozgquz6rli@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211129161650.dtcvh2ozgquz6rli@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N23SCsPjt86ZyCV1TMgZo4dEBLFwAknz
X-Proofpoint-ORIG-GUID: _uHkz7cXTpMN6reHcXe2n2BvVvnhNZnz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111290081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/29/21 11:16, Christian Brauner wrote:
> On Mon, Nov 29, 2021 at 09:35:39AM -0600, Serge Hallyn wrote:
>> On Mon, Nov 29, 2021 at 09:46:55AM -0500, James Bottomley wrote:
>>> On Mon, 2021-11-29 at 15:22 +0100, Christian Brauner wrote:
>>>> On Mon, Nov 29, 2021 at 09:10:29AM -0500, James Bottomley wrote:
>>>>
> I kept thinking about this question while I was out running and while I
> admittedly have reacted poorly to CLONE_NEWIMA patches before it feels
> to me that this is the right approach after all. Making it part of
> userns at least in this form isn't clean.
>
> I think attaching a uuid to a userns alone for the sake of IMA is wrong.
> Additionally, I think a uuid only for the userns is too limited. This is
> similar to the problem of the audit container id. If we have some sort
> of uuid for ima it will automatically evolve into something like a
> container id (I'm not even arguing that this is necessarily wrong.).
> We also have the issue that we then have the container audit id thing -
> if this ever lands and the ima userns uuid. All that makes it quite
> messy.
>
> I think CLONE_NEWIMA is ultimately nicer and allows the implementation
> to be decoupled from the userns and self-contained as possible. This
> also means that ima ns works for privileged containers which sure is a
> valid use-case.

The thing is that piggy backing on the user namespace at least allows us 
to 'always see' where IMA's keyring is (across setns()). If we were 
using an independent IMA namespace how would we guarantee that the user 
sees the keyring for IMA appraisal? We would at least have to take a 
reference (as in get_user_ns()) to the user namespace when the IMA 
namespace is created so that it at least the association of IMA 
namespace to user namespace remains a constant and the keyring IMA is 
using (and are held by the user namespace) is also constant across 
setns()'s. Otherwise it is possible that the user could do setns() to a 
different user namespace and be confused about the keys IMA is using. So 
at least by piggy backing we have them together. The aspect here may be 
'usability'.

I am somewhat sold on the USER namespace piggy backing thing... as 
suggested by James.


> It will also make securityfs namespacing easier as it can be a keyed
> super where the key is the ima ns (similar to how we deal with e.g.
> mqueue).

Yes, mqueue is where I got the (API usage) idea from how to switch out 
the reference to the user namespace needed for the 'keyed' approach.

I will massage my 20 patch-series a bit more and then post it (for 
reference....). It does have 'somewhat dramatic' things in there that 
stem from virtualizing securityfs for example and IMA being a dependent 
of the user namespace and taking one more reference to the user 
namespace (it is a dependent of) and then the user namespace not being 
able to easily delete:

It's this here to help with an early tear-down to decrease the reference 
counter.

- 
https://github.com/stefanberger/linux-ima-namespaces/commit/1a5d7f2598764ca6f1a8c5a391672543fef83f2c

- 
https://github.com/stefanberger/linux-ima-namespaces/commit/d246f501f977e64333ecbd8bb79994e23b552b9b

- 
https://github.com/stefanberger/linux-ima-namespaces/commit/3b82058936862d7623b3a06bc1749d5efc018ab1#diff-99458ca9139231ac3811dbb0c0fced442c46c7cfdb94e86e4553fc0329d3a79bR647-R651

The teardown variable makes this a controlled process but ... is it 
acceptable?

    Stefan


