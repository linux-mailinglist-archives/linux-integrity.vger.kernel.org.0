Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0512B21F588
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2020 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgGNO4z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jul 2020 10:56:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36810 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbgGNO4y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 10:56:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06EEWx3l077491
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jul 2020 10:56:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3298wumeq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jul 2020 10:56:53 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06EEYTfG087007
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jul 2020 10:56:53 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3298wumepc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 10:56:53 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06EEbm0x000501;
        Tue, 14 Jul 2020 14:56:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 328rbqrjpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 14:56:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06EEung247054926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 14:56:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12BFA4C04E;
        Tue, 14 Jul 2020 14:56:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BB1C4C040;
        Tue, 14 Jul 2020 14:56:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jul 2020 14:56:48 +0000 (GMT)
Message-ID: <1594738607.12900.159.camel@linux.ibm.com>
Subject: Re: Queries regarding portable feature and signing process for EVM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     rishi gupta <gupt21@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Date:   Tue, 14 Jul 2020 10:56:47 -0400
In-Reply-To: <CALUj-gu9-0ZKDvTAOFN1jcbYBUXMymPTJmyD=J6C58mVoKi4pQ@mail.gmail.com>
References: <CALUj-gu9-0ZKDvTAOFN1jcbYBUXMymPTJmyD=J6C58mVoKi4pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_05:2020-07-14,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007140113
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Rishi,

On Tue, 2020-07-14 at 15:54 +0530, rishi gupta wrote:
> Hi Matthew,Mimi,
> 
> Few queries in context of 4.14 kernel:
> - Does it support portable EVM feature.
> - For EVM traditionally we need to sign files on the device itself.
> Can we now use portable EVM as a method to sign files during build
> itself.

Normally new features aren't back ported to stable, but for some
reason this was back ported to stable linux-4.14.y.

In the future, using "git blame" will identify the patch in which a
new feature is added.  From there, you can use "git branch -r --
contains <commit number>" to see in which release it was introduced.

Mimi
