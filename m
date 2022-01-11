Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A4E48BB0B
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 23:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245335AbiAKWzA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jan 2022 17:55:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245384AbiAKWzA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jan 2022 17:55:00 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BLAqO4014969;
        Tue, 11 Jan 2022 22:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lGKny6BRVT9I6YxbfmrywxA1StAM5e2OipAhtJiEQio=;
 b=OSAkb2Auo6UsEBC7DoiNIiEyDlliXCutaO3Fv1S6AbfDaeRPu5HldKSxhaBK3gnqn8O/
 sPG7YnNfxGOqAzcYjM23J2ocuvkRXQyOakU5s/mCe48ZZ7Kqeq54cTgUU1MIJKrnK+IP
 nl/zjcii9sfGp1BtYi3ZPtcZxIEaAs3B9K7QbWdpnEC/j+DLxD9UOv2wYnS9BeD2Y/cN
 55vlWJlFjdK+V/ENRISJaP1wsirOTLQqdkGwLPB6njjHDhS2j392smr2aWC00MPWJKn5
 XZ9mZBI1+XZAip72gqAnintC8qyIVlyyb8nuJAMbOQcWc4v+esGRCVnHyQ/1g6L73Opa Xg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dhd08gv31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 22:54:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20BMlta6021511;
        Tue, 11 Jan 2022 22:54:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3df289m48e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 22:54:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20BMssfW47448480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 22:54:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BA47A4059;
        Tue, 11 Jan 2022 22:54:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A16BA404D;
        Tue, 11 Jan 2022 22:54:53 +0000 (GMT)
Received: from sig-9-65-73-162.ibm.com (unknown [9.65.73.162])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jan 2022 22:54:53 +0000 (GMT)
Message-ID: <e645dbdcd74699ff92242c51f743cffe0ea3ae14.camel@linux.ibm.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.17
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Jan 2022 17:54:52 -0500
In-Reply-To: <CAHk-=wi6O9cpRxWEnYMXjeMis47456UrVCksV6K_WCgjUmYEXQ@mail.gmail.com>
References: <41707c7dd9705b8bb04a6d56aee349ff17c4af50.camel@linux.ibm.com>
         <CAHk-=wi6O9cpRxWEnYMXjeMis47456UrVCksV6K_WCgjUmYEXQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sGHypL8zpKWOkMq3pvbeUimqSf7Uybk8
X-Proofpoint-GUID: sGHypL8zpKWOkMq3pvbeUimqSf7Uybk8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=928 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201110118
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-01-11 at 13:21 -0800, Linus Torvalds wrote:
> On Mon, Jan 10, 2022 at 2:02 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.17
> 
> Side note: I can't find the key you're using for the tag signing anywhere.
> 
> This isn't new, and I've seen this key before, and I suspect it's just
> another new key update that the complete breakdown of all the pgp
> keyservers makes hard to get out.
> 
> You used to use RSA key 8D2302082EFE723A379ECCD26B792466B03E715A,
> which I have, the last few pulls you've been using EDDSA key
> 1D5D554518DE57A8AAF51E3ECBC19CD1B02AE7E5 that I can't actually find.

Yes, I received the Nitrokey Start and followed the maintainer-pgp-
guide (and Nitrokey) directions at the time.  It was hard finding a
working gpg server, but I finally found one, at least I thought I found
one.

> 
> It also isn't in the kernel.org pgpkeys repo.
> 
> You could try submitting it there:
> 
>   https://korg.docs.kernel.org/pgpkeys.html#submitting-keys-to-the-keyring
> 
> Oh, how I hate pgp. I thought that having git wrap all the key
> verification would make it usable (counter-example: the incredible
> garbage that is pgp signed email), but then the keyservers stopped
> working, and so the keys themselves end up being a problem.

Submitted.

Mimi

