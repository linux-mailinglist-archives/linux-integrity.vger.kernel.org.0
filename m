Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5916A82A
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2020 15:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBXORv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Feb 2020 09:17:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbgBXORv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Feb 2020 09:17:51 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01OEBZxF026512
        for <linux-integrity@vger.kernel.org>; Mon, 24 Feb 2020 09:17:50 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1b7b7gj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 24 Feb 2020 09:17:50 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 24 Feb 2020 14:17:48 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Feb 2020 14:17:45 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01OEGmqn50135496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 14:16:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A33E2AE056;
        Mon, 24 Feb 2020 14:17:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0706CAE045;
        Mon, 24 Feb 2020 14:17:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.188.252])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Feb 2020 14:17:43 +0000 (GMT)
Subject: Re: [PATCH] Add support for TSS2 for PCR reading
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Patrick Uiterwijk <patrick@puiterwijk.org>,
        linux-integrity@vger.kernel.org
Cc:     pbrobinson@redhat.com
Date:   Mon, 24 Feb 2020 09:17:43 -0500
In-Reply-To: <1581905459.8515.199.camel@linux.ibm.com>
References: <CAJweMdarWZ7j5XrHbPqcp3ZV-XfzVBfeva5tMiuHMkd4M5HxMg@mail.gmail.com>
         <1581905459.8515.199.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022414-0008-0000-0000-00000355F5B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022414-0009-0000-0000-00004A770E6C
Message-Id: <1582553863.10443.67.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_04:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=980 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240117
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Patrick,

On Sun, 2020-02-16 at 21:10 -0500, Mimi Zohar wrote:
> On Sat, 2020-01-25 at 02:15 -0800, Patrick Uiterwijk wrote:
> > Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
> 
> The new ifdef in tpm2_pcr_read() is rather long, cluttering evmctl.c.
>  Moving tpm2_pcr_read() to it's own file, perhaps naming it tpmtss.c,
> will help.

Could you make this change based on top of the patch set "[RFC PATCH
0/8] ima-evm-utils: calculate per TPM bank template digest" I posted
late last week?

thanks,

Mimi

