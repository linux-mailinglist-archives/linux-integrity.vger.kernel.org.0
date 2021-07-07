Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8051E3BEBFB
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 18:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhGGQVp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 12:21:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230273AbhGGQVo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 12:21:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167G7QwY047041;
        Wed, 7 Jul 2021 12:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=eexZY8NDH5fEo/x77raCw5bT0pFhj1xnSvLHXJxCmUA=;
 b=cNXVacamf8rOyJJuXvlg2DarfABNOKwpSEDD2y82XfFdK03t9f+hXluvP0lnCy7jqQQ0
 8siEyMXm8E4l015YSZ/Q49QQd0A/K2H0GgQzZ1ng4hYg9XUW79eaN0B3aqJTzup9fXdn
 B45H8Db6uFprT5WarvKUcntIlXCcVL53y+nG6gUBxZkbeqoTFP1mtdhdWspkugGq31xc
 jES8GFqQJ8DroVQNLCMoqhxuuQgN5oY5C2ZeA2wthK4GThUc0BFfzfRe1z/Xo6Qa1CE6
 dAjCHJS+J3BryqNTHggWKp+6D2Rf7zdHRZumm92gCoOxSnLOCmJMCAagVCLbzqxXbY5x PQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39mk52p09k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 12:19:03 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 167GI6UY019750;
        Wed, 7 Jul 2021 16:19:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 39jfh8gyy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 16:19:00 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 167GIwCY20185558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Jul 2021 16:18:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55DC84203F;
        Wed,  7 Jul 2021 16:18:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1F5342049;
        Wed,  7 Jul 2021 16:18:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.79.186])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Jul 2021 16:18:57 +0000 (GMT)
Message-ID: <10dde047d76b447f32ca91356599be679b8a76e5.camel@linux.ibm.com>
Subject: Re: Weak hash algorithms allowed with DIGEST_NG
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Wed, 07 Jul 2021 12:18:56 -0400
In-Reply-To: <AM4PR0902MB174890B0AB5F5D96E4366FFD941A9@AM4PR0902MB1748.eurprd09.prod.outlook.com>
References: <AM4PR0902MB1748D83387C6F3D39C98992F941A9@AM4PR0902MB1748.eurprd09.prod.outlook.com>
        ,<96afb16f1f9ac6a476b8fb7be988f90267837c6c.camel@linux.ibm.com>
         <AM4PR0902MB174890B0AB5F5D96E4366FFD941A9@AM4PR0902MB1748.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 876brXGEwAqBsVFr6fTtPQySRIOhenmc
X-Proofpoint-GUID: 876brXGEwAqBsVFr6fTtPQySRIOhenmc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_08:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070093
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-07-07 at 15:10 +0000, THOBY Simon wrote:

> > > Is there any way to enforce the use of the hash specified in the
> > > 'ima_hash' cmdline parameter ?
> > 
> > The cmdline parameter overrides the compile time default hash algorithm
> > used for (re-)calculating the file hash.
> > 
> 
> Yes, but that only applies to the hashes performed automatically by the kernel,
> not to a user relabelling his whole / with
> find / \( -fstype rootfs -o -fstype ext4 \) -type f -uid 0 -exec evmctl ima_hash '{}' 2> /dev/null \;
> and forgetting to specify a stronger algorithm (that's how I learned of this pitfall myself).

If you were interested in limiting which algorithms could be used, the
change would be made in ima_inode_setxattr().  I'd be interested in
seeing what you come up with.

thanks,

Mimi

