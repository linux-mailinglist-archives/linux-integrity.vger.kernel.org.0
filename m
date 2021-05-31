Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD8396488
	for <lists+linux-integrity@lfdr.de>; Mon, 31 May 2021 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhEaQDA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 May 2021 12:03:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230308AbhEaQAw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 May 2021 12:00:52 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14VFcFIL088905;
        Mon, 31 May 2021 11:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MbQJoW+uSYC3MhQzAUeotJa8WDXDGWMqBHniGRV0EI4=;
 b=Pefz5wmSHm7OQ3z76C2DQTjK8HN1ppm/pfk+cm/WG3fDD2mXcJm9ZEEEgWcGYYgI47tD
 /ECWtfXZhaH5vfES2foyby84ZPLQvcsCRpQiTGrmvH4UfN+DBRnaTJqcg70Gmx59Magb
 t38qrICJgsADOUYqMaTrlsn+YfPPWNxIf51qGzSaSoUlmtMDk4gnR4rAY+aLA5yCfuow
 2wiHfTgnaetzjELFfvV1VRWKf3oR5UgjupQ9I8p9HDoBm1OKYFHvvndpkUDTYWgaK1ob
 FDiSjIaGlARRxkPtsXgR3IuKu3Jo7QV5hKsYAolV3zrvYoH9NOqynHFnPmibaDLGgRX3 Tw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38w11uk0sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 11:58:28 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14VFwNUn002969;
        Mon, 31 May 2021 15:58:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 38ucvh8me8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 15:58:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14VFvrOX35979670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 15:57:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 652A542042;
        Mon, 31 May 2021 15:58:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 310424203F;
        Mon, 31 May 2021 15:58:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.84.117])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 May 2021 15:58:23 +0000 (GMT)
Message-ID: <73739875882e9f7416f0958f8589a09089e53d9e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/7] ima: Add template fields to verify EVM portable
 signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@srcf.ucam.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 31 May 2021 11:58:20 -0400
In-Reply-To: <20210528073812.407936-1-roberto.sassu@huawei.com>
References: <20210528073812.407936-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lRxu8V3qGNS4nn_Tn_5W4pqZHjQYYytD
X-Proofpoint-ORIG-GUID: lRxu8V3qGNS4nn_Tn_5W4pqZHjQYYytD
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-31_08:2021-05-31,2021-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105310114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-05-28 at 09:38 +0200, Roberto Sassu wrote:
> The recent patch set 'evm: Improve usability of portable signatures' added
> the possibility to include EVM portable signatures in the IMA measurement
> list.
> 
> However, the information necessary to verify the signature were not
> included in the IMA measurement list. This patch set introduces new
> template fields to accomplish this goal:
> 
> - 'iuid': the inode UID;
> - 'igid': the inode GID;
> - 'imode': the inode mode;
> - 'xattrnames': a list of xattr names (separated by |), only if the xattr is
>   present;
> - 'xattrlengths': a list of xattr lengths (u32), only if the xattr is present;
> - 'xattrvalues': a list of xattr values;
> 
> Patch 1 adds an helper function to show integers in the measurement list.
> Patches 2, 3 and 5 introduce new template fields. Patch 4 make it possible
> to verify EVM portable signatures which protect xattrs belonging to LSMs
> not enabled in the target platform. Patch 6 introduces the new IMA template
> evm-sig. Patch 7 fixes a small issue in evm_write_xattrs() when audit is
> not enabled.

Thanks, Roberto. 

Applied to: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
next-integrity-testing branch.

Mimi

