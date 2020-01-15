Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670B813CC34
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2020 19:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAOSga (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jan 2020 13:36:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728993AbgAOSga (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jan 2020 13:36:30 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FIPnUT106645
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2020 13:36:28 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xhbpsed3u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2020 13:36:28 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 15 Jan 2020 18:36:26 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 Jan 2020 18:36:23 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00FIaM6C57737346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 18:36:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B69C5A4055;
        Wed, 15 Jan 2020 18:36:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1165AA4053;
        Wed, 15 Jan 2020 18:36:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.153.48])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jan 2020 18:36:21 +0000 (GMT)
Subject: Re: [PATCH v4] ima: ima/lsm policy rule loading logic bug fixes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Date:   Wed, 15 Jan 2020 13:36:21 -0500
In-Reply-To: <20200115154230.2048-1-janne.karhunen@gmail.com>
References: <20200115154230.2048-1-janne.karhunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011518-4275-0000-0000-00000397DBEB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011518-4276-0000-0000-000038ABD88E
Message-Id: <1579113381.5032.20.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001150141
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-01-15 at 17:42 +0200, Janne Karhunen wrote:
> Keep the ima policy rules around from the beginning even if they appear
> invalid at the time of loading, as they may become active after an lsm
> policy load. However, loading a custom IMA policy with unknown LSM
> labels is only safe after we have transitioned from the "built-in"
> policy rules to a custom IMA policy.
> 
> Patch also fixes the rule re-use during the lsm policy reload and makes
> some prints a bit more human readable.
> 
> Changelog:
> v4:
> - Do not allow the initial policy load refer to non-existing lsm rules.
> v3:
> - Fix too wide policy rule matching for non-initialized LSMs
> v2:
> - Fix log prints
> 
> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>

Thanks, the updated patch is now queued in next-integrity-testing.

Mimi

