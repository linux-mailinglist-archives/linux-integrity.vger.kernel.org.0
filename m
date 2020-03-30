Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03CA1982F3
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 20:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgC3SFn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 14:05:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727954AbgC3SFm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 14:05:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UI4SZW113453
        for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2020 14:05:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 301ygv5w46-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2020 14:05:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 30 Mar 2020 19:05:38 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Mar 2020 19:05:35 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02UI5Z8X54263896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 18:05:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97B45A4060;
        Mon, 30 Mar 2020 18:05:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D835AA405F;
        Mon, 30 Mar 2020 18:05:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.180.158])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Mar 2020 18:05:34 +0000 (GMT)
Subject: Re: [PATCH] integrity ima_policy : Select files by suffix
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Lev R. Oshvang ." <levonshe@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@us.ibm.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Mon, 30 Mar 2020 14:05:34 -0400
In-Reply-To: <CAP22eLGbwcXzBDpc2QbMOGtjrdYsufUf-8vq4uHt8jjPoQanKQ@mail.gmail.com>
References: <20200330122434.GB28214@kl>
         <1244b6bcc384413581da33c9b92743b8@huawei.com>
         <CAP22eLGbwcXzBDpc2QbMOGtjrdYsufUf-8vq4uHt8jjPoQanKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20033018-0028-0000-0000-000003EED666
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033018-0029-0000-0000-000024B4563A
Message-Id: <1585591534.5188.435.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_07:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003300154
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[The normal conventions for this mailing list is bottom post.]

Lev,

On Mon, 2020-03-30 at 20:21 +0300, Lev R. Oshvang . wrote:
> I already answered to Mimi Zohar that applications expect file name in
> open() syscall.

And I disagreed with you.  Not only can filenames be renamed, as I
mentioned, but they aren't protected, as Roberto said.

> So there is no need to protect file name otherwise applications just
> stop to work.
> Even now when ima hash is not correct application stops to work.
> Put aside scripts for a second. A lot of programs are configured in
> .ini or .conf files.
> The suffix is a very convenient way to provide these files would be measured.
> 
> Now I returning to scripts.
> It is very hard to enforce IMA checks in interpreters. And thinks
> about perl scrips. awk. python scripts. etc
> The proposed suffix rule is easy and lightweight.
> I once had programmed BRM hook of LSM
> I had a very hard time trying to figure out whether shell is opening a
> script or data , how to get filename to check its signature.
> Sometimes script file does not have shebang or does not have
> executable permission.

Only the interpreter knows how the file will be used.

> 
> I hope I convinced you.

There have been a number of attempts to define IMA policy rules based
on pathname, which have not been upstreamed.  Feel free to use your
solution, but it can't be upstreamed as is.
  
Mimi

