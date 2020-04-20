Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154971B1557
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2020 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgDTTF5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Apr 2020 15:05:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbgDTTF5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Apr 2020 15:05:57 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KIYg6w050035
        for <linux-integrity@vger.kernel.org>; Mon, 20 Apr 2020 15:05:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmuxstf5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 20 Apr 2020 15:05:56 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 20 Apr 2020 20:05:32 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Apr 2020 20:05:28 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03KJ5oA854591690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 19:05:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B9C611C070;
        Mon, 20 Apr 2020 19:05:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 902F611C052;
        Mon, 20 Apr 2020 19:05:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.201.119])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Apr 2020 19:05:49 +0000 (GMT)
Subject: Re: IMA: policy update LSM rules failed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Yiyang Su <suyiyang@hotmail.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "James Morris <jmorris@namei.org>" 
        <IMCEASUPPORTER-SECURITY+20SUBSYSTEM@EURPRD10.PROD.OUTLOOK.COM>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Apr 2020 15:05:49 -0400
In-Reply-To: <AM6PR10MB240500A3E665DAA3807E0BF5C8D40@AM6PR10MB2405.EURPRD10.PROD.OUTLOOK.COM>
References: <AM6PR10MB240500A3E665DAA3807E0BF5C8D40@AM6PR10MB2405.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042019-0012-0000-0000-000003A81DC7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042019-0013-0000-0000-000021E56885
Message-Id: <1587409549.5446.1.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_07:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-04-20 at 17:51 +0000, Yiyang Su wrote:
> Hello,
> 
> Current i am using Kernel 4.14.169 and trying to add some LSM rules such as "measure subj_user=_ func=FILE_CHECK mask=MAY_READ" into ima policy, but i cannot update the policy. Same happens by updating for subj_role, subj_type, obj_user, obj_role, and obj_type.
> 
> The issue can be produced:
> ###
> echo "measure subj_user=_ func=INODE_PERM mask=MAY_READ" > /sys/kernel/security/ima/policy
> sh: write error: Invalid argument
> IMA: policy update failed
> 
> [ 1558.886333] audit: type=1805 audit(1587051889.726:28): action="measure" subj_user="_" res=0
> [ 1558.903324] audit: type=1802 audit(1587051889.726:29): pid=255 uid=0 auid=4294967295 ses=4294967295 op="update_policy" cause="invalid-policy" comm="sh" res=0
> [ 1558.917414] audit: type=1300 audit(1587051889.726:29): arch=40000028 syscall=4 per=800000 success=no exit=-22 a0=1 a1=aab98 a2=32 a3=0 items=0 ppid=1 pid=255 auid=4294967295 uid=0 gid=0 euid=0 suid=0 )
> [ 1558.945176] audit: type=1327 audit(1587051889.726:29): proctitle="-sh"
> [ 1558.951699] audit: type=1802 audit(1587051889.736:30): pid=255 uid=0 auid=4294967295 ses=4294967295 op="policy_update" cause="failed" comm="sh" res=0
> ###
> 
> But there is no problem to update a rule such as "measure fowner=55"
> ###
> echo "measure fowner=55" > /sys/kernel/security/ima/policy
> IMA: policy update completed
> ###
> 
> The kernel option CONFIG_IMA_LSM_RULES=y is enabled.

Perhaps the difference isn't the LSM options, but the "func="
definition?  I've never seen "func=INODE_PERM".

Mimi 

