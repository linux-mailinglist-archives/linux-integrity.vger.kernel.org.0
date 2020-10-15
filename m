Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6845128F2B9
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Oct 2020 14:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJOMyN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Oct 2020 08:54:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgJOMyN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Oct 2020 08:54:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09FCjuDq034542;
        Thu, 15 Oct 2020 08:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5cDpXc0YeserX2g9Mjmou+p7xF5Irq0JanmtvsChu5g=;
 b=WdtXaT9VF4f5rr30bg6h5B8eISR57tienH2fMrICXkSe5m5O7jT4QGnzYkypY5qGdmlC
 l54JWB4HJONpJbDi+8dJ6fWsGR8/xd+5KfF/G1S7yh7htOzkDgBIM9xZXWY2VFHWS9ZI
 s/Reu6RjIivh+uUPDqBOShOAIxBn5dl4uXZozi7SIb2HEFZcylknss9JQ9eQ9H/mtd+W
 EXtbtoe3llNTI3JgReYYFBMUB679H0qK7mJDehHmaVTmg4XYMMoT5bNmQTWZyj+xRTIb
 IyiKB7WR0oHpLaxgQBzSFDOOr/XrtZP/yV/fWtXPrgJrMGRP2pVjxfyPmxgZmrGRqI85 WQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 346pqgg8pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 08:54:10 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09FCpmii016665;
        Thu, 15 Oct 2020 12:54:09 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3434k9c7ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 12:54:09 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09FCs8iO49086788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 12:54:08 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9136112061;
        Thu, 15 Oct 2020 12:54:08 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6236112063;
        Thu, 15 Oct 2020 12:54:08 +0000 (GMT)
Received: from [9.80.236.207] (unknown [9.80.236.207])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Oct 2020 12:54:08 +0000 (GMT)
Subject: Re: [PATCH v2 1/5] ima-evm-utils: Change env variable TPM_SERVER_TYPE
 for tpm_server
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Ken Goldman <kgoldman@us.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
 <20201012234416.20995-2-kgoldman@us.ibm.com>
 <ac8d885af1f79a8d1e2c137654b9924693b328b1.camel@linux.ibm.com>
 <fc912ea2-ef89-7fc4-8bf2-5f107b8cfc7e@linux.ibm.com>
 <a0060e2dd23281b1dbcc0d71f7615d46dd6f5aa7.camel@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <7db39195-0e73-5958-03e3-7850bf5eb6b5@linux.ibm.com>
Date:   Thu, 15 Oct 2020 08:54:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <a0060e2dd23281b1dbcc0d71f7615d46dd6f5aa7.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-15_07:2020-10-14,2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/14/2020 6:28 PM, Mimi Zohar wrote:
>>> Instead of adding a comment here, how about only exporting
>>> TPM_SERVER_TYPE for "swtpm".

>> That certainly works.  I thought the idea was, "Make the
>> smallest change that fixes the problem."   Moving that
>> line under swtpm is a reasonable alternative.

> In this case, moving the line and adding the comment is the smallest
> change.  To indicate this is a bug fix, you would add "Fixes:
> f831508297cd ("Install the swtpm package, if available") in addition to
> your Signed-off-by tag.
> 

The current patch adds one line.  This proposal adds one line and
moves another line.  It also changes the swtpm flow, which must
be tested.

It's OK with me.  Let me know.

Where should I add that "Fixes ..." text?  What is the exact format?


