Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041594663ED
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 13:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357898AbhLBMuW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 07:50:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15452 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347388AbhLBMuW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 07:50:22 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2BNQWO031635;
        Thu, 2 Dec 2021 12:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=3hXA/kZ8cttkItCz5wN6XJFfxji6OOhKwPo1uBwRm6c=;
 b=muqlrP491UAkDbILVryfZ9HgdpRTMu6rFDEae/Ef4INnxopZIow7PKnChMm2LbUcNxBm
 xecsWgMNtwhS8ycAkFSgl0NydWuZDkUB+mTDdlTmGq19emLMcGpMh+tZ3agOhCZA3sQg
 TUJv9UTdlTobODj3jq/3cy3K6lnJZboftPxAH8uit3ojh11kZfS92wWaGyTOlIQrw9Ir
 yfn5XAKD7Ig4oKbLhmBGk7uwWoF5df28XSCEPYV8VVT7UTbDfSyXBWDKeeJLeUfT/Cr9
 HM1JP15TnCxWxguLT1Na//B4E+Nx4yJavGTLi+qETO1+ynSLMJ6ixh4K0GXhRfjVHWIT jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpw7t9kfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 12:46:43 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2CUgnZ027850;
        Thu, 2 Dec 2021 12:46:43 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpw7t9kfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 12:46:43 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2Cdi1I020986;
        Thu, 2 Dec 2021 12:46:42 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3ckcaccvws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 12:46:42 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2CkeQS49611192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 12:46:40 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE3FF7806E;
        Thu,  2 Dec 2021 12:46:39 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C28FE78066;
        Thu,  2 Dec 2021 12:46:37 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 12:46:37 +0000 (GMT)
Message-ID: <141ce433f026b47edb1d9a8f89e4581db253c579.camel@linux.ibm.com>
Subject: Re: [RFC 08/20] ima: Move measurement list related variables into
 ima_namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Thu, 02 Dec 2021 07:46:36 -0500
In-Reply-To: <20211130160654.1418231-9-stefanb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
         <20211130160654.1418231-9-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T09BanDLEgX0wX9EPjPKPhK2YZuaEPfi
X-Proofpoint-GUID: 2K7t0JURPY-TD3zyVDNCAr7tDbuOCg4m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-12-02_07,2021-12-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1015 impostorscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020080
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
> Move measurement list related variables into the ima_namespace. This
> way a
> front-end like SecurityFS can show the measurement list inside an IMA
> namespace.
> 
> Implement ima_free_measurements() to free a list of measurements
> and call it when an IMA namespace is deleted.

This one worries me quite a lot.  What seems to be happening in this
code:

> @@ -107,7 +100,7 @@ static int ima_add_digest_entry(struct
> ima_namespace *ns,
>         qe->entry = entry;
>  
>         INIT_LIST_HEAD(&qe->later);
> -       list_add_tail_rcu(&qe->later, &ima_measurements);
> +       list_add_tail_rcu(&qe->later, &ns->ima_measurements);
>  
>         atomic_long_inc(&ns->ima_htable.len);
>         if (update_htable) {
> 

is that we now only add the measurements to the namespace list, but
that list is freed when the namespace dies.  However, the measurement
is still extended through the PCRs meaning we have incomplete
information for a replay after the namespace dies?

I tend to think the way this should work is that until we have a way of
attesting inside the namespace, all measurements should go into the
physical log, so that replay is always complete for the PCRs, so
effectively the visible log of the namespace would always have to be a
subset of the physical log.

James


