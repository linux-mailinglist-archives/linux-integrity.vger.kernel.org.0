Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B874037B174
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 00:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEKWNl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 18:13:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhEKWNl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 18:13:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BM3qJX013071;
        Tue, 11 May 2021 18:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=t3LKdFuRFzAxYNFSKSFqcjKDsEQ3jHHlgnRe5mxjDTY=;
 b=YTld7HOCvPo9BzMZymJ2fMVP2may5cS28pg9xMTdOnPZDxTRHUn7yU9SAMXHTdtjEbid
 hUUnHjqdwDJiqlqYITQrhautOGkNj7NYSEdySDZxxptCDDdUV44mDJccoi48YdciG34g
 2sBIzvmiADvjZNuR1vxEl6kJ0FgHLwP6/TuH43rhbTxXSHtZVpfqdQ7pqQUSV8qgWWuW
 kOezcGwCEdUDJF0symDqgbpjcPWypggajmQGuKXN1DO33E5aLmr8LVXiOwz2PegcsQVB
 4UYGCqBkK5UcBIDTM6Zvcw+EkNRvSaP+K1FCkracXtuBVtIHbbv4UgbUIlbixQFk+rMG lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38g23v0kmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 18:12:30 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14BM3xRv013519;
        Tue, 11 May 2021 18:12:30 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38g23v0kmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 18:12:30 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BMCSEZ016694;
        Tue, 11 May 2021 22:12:28 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 38dhwh9vd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 22:12:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BMCPD132309568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 22:12:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0BF54203F;
        Tue, 11 May 2021 22:12:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99C2A42045;
        Tue, 11 May 2021 22:12:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.116.76])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 May 2021 22:12:24 +0000 (GMT)
Message-ID: <f1e16fe91bd80437ea2cf9ed60c40a3687fa0e40.camel@linux.ibm.com>
Subject: Re: [PATCH v6 10/11] ima: Introduce template field evmsig and write
 to field sig as fallback
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 May 2021 18:12:23 -0400
In-Reply-To: <20210505113329.1410943-6-roberto.sassu@huawei.com>
References: <20210505112935.1410679-1-roberto.sassu@huawei.com>
         <20210505113329.1410943-6-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IB94wreSnh83ny7E9fTm1tYMmlSkKC_W
X-Proofpoint-ORIG-GUID: x8W11_q3a1dFYaT3I_aG-LvbEVYDfSNl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_04:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110148
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Wed, 2021-05-05 at 13:33 +0200, Roberto Sassu wrote:
> With the patch to accept EVM portable signatures when the
> appraise_type=imasig requirement is specified in the policy, appraisal can
> be successfully done even if the file does not have an IMA signature.
> 
> However, remote attestation would not see that a different signature type
> was used, as only IMA signatures can be included in the measurement list.
> This patch solves the issue by introducing the new template field 'evmsig'
> to show EVM portable signatures and by including its value in the existing
> field 'sig' if the IMA signature is not found.

With this patch, instead of storing the file data signature, the file
metadata signature is stored in the IMA measurement list, as designed. 
There's a minor problem.  Unlike the file data signature, the
measurement list record does not contain all the information needed to
verify the file metadata signature.

thanks,

Mimi

