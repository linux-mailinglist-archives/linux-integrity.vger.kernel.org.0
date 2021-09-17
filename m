Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09FA40FA24
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhIQObJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Sep 2021 10:31:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4260 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242004AbhIQObB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Sep 2021 10:31:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HEDM5B028118;
        Fri, 17 Sep 2021 10:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+ueAxv5B2jVTA2djf3TgXCUAF3XljHSLWyJxOMJAqSo=;
 b=lLdWxNeqt84hzK8+SPIXqsJ2RjT8tPAXRAEIkB87JLoPpKVhTTgwVPhB/yyQMspk1GqI
 nO0cwIpr5UXim6SkhFZqdpl0h7Ser967Gr86Eu0Aw71Iy6bCPwvOs8WZoUvKLrPJ8s7/
 mcBrsncFNvGRqRNIP4R7Ts/Z9rDvdrYwkwzFjoMHMzQB8hvAAERyDBWKa9gSq+dvMEWt
 Mna2IgF6M/pnIXyiZj6e/k1b7uruDfOzCTgzsw5mkv/MIYPogLUebbkpLWFlQ0zBVMo5
 DRqPgW0VywfHAblZUkvIz9GLCTzuqk+cngNn/jxvu5P+tuKEBI9Yhad/tOBpy8lWqJJw IQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b4mfv4c89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 10:29:25 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18HED26C005951;
        Fri, 17 Sep 2021 14:27:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3b0m3adcgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 14:27:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18HEN6Ni57671954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 14:23:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 816134C040;
        Fri, 17 Sep 2021 14:27:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 164184C046;
        Fri, 17 Sep 2021 14:27:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.166.232])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Sep 2021 14:27:40 +0000 (GMT)
Message-ID: <b22ad457ce54955ab160f4f48940887ebdee94d4.camel@linux.ibm.com>
Subject: Re: [zohar-integrity:next-integrity-testing 1/1]
 security/integrity/ima/ima_policy.c:684:25: sparse: sparse: incompatible
 types in comparison expression (different address spaces):
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     liqiong <liqiong@nfschina.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-integrity@vger.kernel.org,
        THOBY Simon <Simon.THOBY@viveris.fr>
Date:   Fri, 17 Sep 2021 10:27:40 -0400
In-Reply-To: <1b6c2bf0-cd29-436b-9cdc-2e2a6405601a@nfschina.com>
References: <202109150609.vPQhnWpw-lkp@intel.com>
         <1b6c2bf0-cd29-436b-9cdc-2e2a6405601a@nfschina.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O0aEwq7J-RCsmj2mX6ED6FF9oe9QcIw2
X-Proofpoint-ORIG-GUID: O0aEwq7J-RCsmj2mX6ED6FF9oe9QcIw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_06,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=907 priorityscore=1501 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109170091
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-09-16 at 20:05 +0800, liqiong wrote:
> Hi Mini,
> 
> I got this sparse warnings, should i fix it ?
> 
> It seems the follow patch can fix, but i don't think should do
> this check (ima_rules_tmp == NULL).
> 
> 
> -static struct list_head *ima_rules = &ima_default_rules;
> +static struct list_head __rcu *ima_rules = (struct list_head __rcu *)(&ima_default_rules);
> 
> ima_rules_tmp = rcu_dereference(ima_rules);
> +if (ima_rules_tmp == NULL)
> +	return ;

Agreed,  the "__rcu" annotation is missing.  Probably both ima_rules
and ima_rules_tmp should be annotated with "__rcu".   Agreed,
ima_rules_tmp will either point to the default or custom policy rules. 
No need for the check.

Please post a new version of the patch, with "Reported-by: kernel test
robot <lkp@intel.com>  (Fix sparse: incompatible types in comparison
expression)".

thanks,

Mimi

