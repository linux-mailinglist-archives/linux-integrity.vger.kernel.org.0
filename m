Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F4D49E452
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbiA0ONQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 09:13:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237462AbiA0ONP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 09:13:15 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RDLa1I001407;
        Thu, 27 Jan 2022 14:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2mEKE2mLE734ZV7DyqQGgRuJkpcK3WlaLUk4wvuYRZI=;
 b=dOx084y2SjMT0NJXu6lb8qYDlS9mHyixctu6GzEoGAudDaKijqxMFIzCe/+SJijd52A9
 Jkmpp2pwytLiukEX6kSgH56d1Mr8JgNXhaUr8XvcAVXLRxaT/YR0pmDkiIJ+n3lmH8BG
 WMkNFoRZ/vAE4+paiPvW5gc8at1ZX+wd3BBJX+WUDQSRcHwNiXMCupIs9aSI3K3EIWHs
 40vuwWZdQnT1gjeS5VrApkUEj0XyhREoFjrmYg3wGYGMJj9gpPUQDE23WINA8azKWDcS
 nzl8eFTV+vuT2X372WATn078hugUiSY9Y6FEIJzi4OcxIXp20R2svC8TRWUaV0JXW8rW AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duta8urwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:12:59 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20RDLYB8001277;
        Thu, 27 Jan 2022 14:12:58 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duta8urvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:12:58 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RECNm4016041;
        Thu, 27 Jan 2022 14:12:56 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3dr9j9emcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:12:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RE3FC420709796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 14:03:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4B9B5204E;
        Thu, 27 Jan 2022 14:12:52 +0000 (GMT)
Received: from sig-9-65-89-165.ibm.com (unknown [9.65.89.165])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2E2C352067;
        Thu, 27 Jan 2022 14:12:50 +0000 (GMT)
Message-ID: <4fe1b4fbd47f9ee7ad92eaac7da1db642b126344.camel@linux.ibm.com>
Subject: Re: [PATCH v9 02/23] ima: Do not print policy rule with inactive
 LSM labels
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <brauner@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 27 Jan 2022 09:12:49 -0500
In-Reply-To: <20220126083814.3ndwkhivir573aok@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
         <20220125224645.79319-3-stefanb@linux.vnet.ibm.com>
         <20220126083814.3ndwkhivir573aok@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sOKIoN0drbW1X5ImTYY2H2IYaJNyhRGV
X-Proofpoint-ORIG-GUID: doHH_H6SDmcQxYiHG2pQM1tUNkh0GFJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Christian,

On Wed, 2022-01-26 at 09:38 +0100, Christian Brauner wrote:
> On Tue, Jan 25, 2022 at 05:46:24PM -0500, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Before printing a policy rule scan for inactive LSM labels in the policy
> > rule. Inactive LSM labels are identified by args_p != NULL and
> > rule == NULL.
> > 
> > Fixes: b16942455193 ("ima: use the lsm policy update notifier")

Stefan, please refer to commit 483ec26eed42 ("ima: ima/lsm policy rule
loading logic bug fixes") instead.

> 
> That commit message of the referenced patch reads:
> 
> "Don't do lazy policy updates while running the rule matching, run the
> updates as they happen."
> 
> and given that we had a lengthy discussion how to update the rules I'd
> really would have liked an explanation why the update needs to run
> immediately. Not doing it lazily is the whole reason we have this
> notifier infra. Why can't this be done lazily?

The subject of the original thread leading up to registering a block
notifier is titled
"Subject: sleep in selinux_audit_rule_init".  The message id of the
original thread is 
CAHC9VhS=GsEVUmxtiV64o8G6i2nJpkzxzpyTADgN-vhV8pzZbg@mail.gmail.com.

This patch addresses a bug and could be upstreamed independently the
IMA namespacing patch set.  Should we defer including a summary from
the lazy update to block notifier discussion to "[PATCH v9 11/23] ima:
Move ima_lsm_policy_notifier into ima_namespace"?

thanks,

Mimi

