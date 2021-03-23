Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA29D3464A3
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 17:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhCWQN4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 12:13:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233048AbhCWQNp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 12:13:45 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NG3KPO059534;
        Tue, 23 Mar 2021 12:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gjvixOOjton7uGSXPkTWvW3pgeVJJycqi6LeokrLI8Y=;
 b=H3N9kxk3EMZx5/3tuxdT0noHWKi5L8O0vrRzBLQ2OzSu2nfcb38eTT4cDqPOirOFip9e
 hFzmdsb6ppYnnkl7iUKHBycTL+8cEJEI5zh+NXlC4e7l3iZcafJ9QnbGX4wmz50tu2j9
 27cJeR4FC3vDgY08TH6JLlNV8H7oGag1qE5nBg18hsYSWAMOk3z0cYyfjszKuiqRxBdv
 8s8KYTpIqmf37pALHGScoCRKx3IEeSZ4+EknhEKQQVhhyof0CiwzAqW/DJU5ydaAs8Zr
 6FS4CHu86ZZeuYOqaUkRhpmFwsO5Aib0OOmE/Mg8kFqcNDZfeQgzsxx3Vx7ZHXvZmwAl DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fkaxhaf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 12:13:32 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NG3IW5059450;
        Tue, 23 Mar 2021 12:13:32 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fkaxhae3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 12:13:32 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NG37di015056;
        Tue, 23 Mar 2021 16:13:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 37d9a6httt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 16:13:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NGDRjl44630326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 16:13:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C68142041;
        Tue, 23 Mar 2021 16:13:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F4A542045;
        Tue, 23 Mar 2021 16:13:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.41.170])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Mar 2021 16:13:24 +0000 (GMT)
Message-ID: <721b4f8d38b014babb0f4ae829d76014bbf7734e.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was
 initialized
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Date:   Tue, 23 Mar 2021 12:13:22 -0400
In-Reply-To: <cc01e7b7-d685-289c-a792-fc76fabba807@i-love.sakura.ne.jp>
References: <20210319200358.22816-1-zohar@linux.ibm.com>
         <20210319200358.22816-2-zohar@linux.ibm.com>
         <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
         <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
         <1a2245c6-3cab-7085-83d3-55b083619303@i-love.sakura.ne.jp>
         <8039976be3df9bd07374fe4f1931b8ce28b89dab.camel@linux.ibm.com>
         <cde00350-2a18-1759-d53b-2e7489b6cc0e@i-love.sakura.ne.jp>
         <8a8763a7-eeeb-3578-d50c-c15919fbe1f9@i-love.sakura.ne.jp>
         <3ed2004413e0ac07c7bd6f10294d6b6fac6fdbf3.camel@linux.ibm.com>
         <cc01e7b7-d685-289c-a792-fc76fabba807@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_07:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=885 spamscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230118
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-03-24 at 00:14 +0900, Tetsuo Handa wrote:
> On 2021/03/23 23:47, Mimi Zohar wrote:
> > Initially I also questioned making "integrity" an LSM.  Perhaps it's
> > time to reconsider.   For now, it makes sense to just fix the NULL
> > pointer dereferencing.
> 
> Do we think calling panic() as "fix the NULL pointer dereferencing" ?

Not supplying "integrity" as an "lsm=" option is a user error.  There
are only two options - allow or deny the caller to proceed.   If the
user is expecting the integrity subsystem to be properly working,
returning a NULL and allowing the system to boot (RFC patch version)
does not make sense.   Better to fail early.

Mimi

