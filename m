Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E2931415A
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 22:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhBHVLo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Feb 2021 16:11:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233982AbhBHVLX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Feb 2021 16:11:23 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 118KVBsY045443;
        Mon, 8 Feb 2021 16:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GDYLBbFOkVJC1HP/q1fRWBguXnwo/GkM6DQdTcwJ3YI=;
 b=V77N5/vEoPdRt4Ws2NmbcNKtDX1Q13cE7r5X6J0e2RU+oauQh1BnYXrbWH52CGqi0PUT
 jquf14wQZMq9dYEFdhLXcVPvqTnuN8xwuh6Pzd0EHdnnhgPNVlrKRgkL2EQiOijCZMnL
 poXUHQplJeIWOiZs2tpxzMjhh2z7LdwSwKCuI/+2gyuwrGZt3RF6jY6HCNMV8x8P20vU
 8BN+PM5LuyB+H3DnnLhdCjbCulr2//1Ifgy25mMKuSpHWtAd6+81zEDP1lPGTa1EjoGG
 U4oatclm9cKSHPJEcKzzlxXsjvYfL9sXN8KJFtcQyAf1o7q1Oc+kawjCC/hiOVFna8MD XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36kbuusr3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 16:10:38 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 118KskE0130178;
        Mon, 8 Feb 2021 16:10:38 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36kbuusr2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 16:10:38 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 118KB2Yg006804;
        Mon, 8 Feb 2021 21:10:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 36hskb142s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 21:10:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 118LAXAo35455318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Feb 2021 21:10:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 690E111C054;
        Mon,  8 Feb 2021 21:10:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 398B311C04C;
        Mon,  8 Feb 2021 21:10:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.48.239])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Feb 2021 21:10:29 +0000 (GMT)
Message-ID: <27a4592c3b75861d2b9c8fb1511f593aa987222c.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] support for duplicate measurement of integrity
 critical data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Mon, 08 Feb 2021 16:10:29 -0500
In-Reply-To: <27f73411fc1d6ce6dd16a29344d729d9aa760250.camel@linux.ibm.com>
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
         <27f73411fc1d6ce6dd16a29344d729d9aa760250.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_13:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,


On Mon, 2021-02-08 at 15:22 -0500, Mimi Zohar wrote:
> On Fri, 2021-01-29 at 16:45 -0800, Tushar Sugandhi wrote:
> > IMA does not measure duplicate buffer data since TPM extend is a very
> > expensive operation.  However, in some cases for integrity critical
> > data, the measurement of duplicate data is necessary to accurately
> > determine the current state of the system.  Eg, SELinux state changing
> > from 'audit', to 'enforcing', and back to 'audit' again.  In this
> > example, currently, IMA will not measure the last state change to
> > 'audit'.  This limits the ability of attestation services to accurately
> > determine the current state of the integrity critical data on the
> > system.
> > 
> > This series addresses this gap by providing the ability to measure
> > duplicate entries for integrity critical data, driven by policy.
> 
> The same reason for re-measuring buffer data is equally applicable to
> files.  In both cases, the file or the buffer isn't re-measured if it
> already exists in the htable.   Please don't limit this patch set to
> just buffer data.

Instead of making the change on a per measurement rule basis, disabling
"htable" would be the simplest way of forcing re-measurements.  All
that would be needed is a new Kconfig (e.g. CONFIG_IMA_DISABLE_HTABLE)
and the associated test in ima_add_template_entry().

thanks,

Mimi

