Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F5E3CEFF9
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 01:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbhGSWxz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jul 2021 18:53:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353342AbhGSTsB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 15:48:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JK5Goq025317;
        Mon, 19 Jul 2021 16:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dLLn3Ddivbbar2NOdA09Z05PpfxPdWUI/YG/ZtuVCAk=;
 b=FZMHkmCoQt4LwOip+lhpAmiSRs9RT+G4G93NLiXMWABfSwVCzUmg0VEPw03G7S2EzFbx
 dkhrKGqXDxsIZHjuipFF/hM/SAxwC1MsSqCYC7n095bDYxc2ksc1TAR981jQdAhvB6mp
 74XnO3nmxIdYCVGbghPpzwE3p8aw7FljJGligCYrl/VoEmCAN3bGqW5er0uhHRZTxzVi
 ySEXWKFizLh5HgMIRlqiuqzyymfcdfFAOYtlNpleCBPoKi0aZuY6LtDEamjWxDzPw5yA
 WEb2danQXvKNJwhaUDWZ36cSu1QPdJlKgT2RTCURaDRRbWblOSFBBJaCnblJt163B5Vl Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wdkywdjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 16:28:20 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16JK5T7w026703;
        Mon, 19 Jul 2021 16:28:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wdkywdhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 16:28:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JKDJqu022880;
        Mon, 19 Jul 2021 20:28:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 39upu88vvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 20:28:17 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JKSEh523659004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 20:28:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF211A4085;
        Mon, 19 Jul 2021 20:28:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFEF3A4093;
        Mon, 19 Jul 2021 20:28:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.28.163])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jul 2021 20:28:12 +0000 (GMT)
Message-ID: <2f4920dbdb16156e1af5cf78f592a5cf07ec3176.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] ima: Return int in the functions to measure a
 buffer
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, prsriva02@gmail.com,
        tusharsu@linux.microsoft.com, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Date:   Mon, 19 Jul 2021 16:28:11 -0400
In-Reply-To: <20210705090922.3321178-3-roberto.sassu@huawei.com>
References: <20210705090922.3321178-1-roberto.sassu@huawei.com>
         <20210705090922.3321178-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2w5KZhLCtpdbMpDvISgprZ3YBpu6-GOI
X-Proofpoint-ORIG-GUID: JV2oPkGbMj6r63Rb6FYfBEFd3b74dq70
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_10:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Mon, 2021-07-05 at 11:09 +0200, Roberto Sassu wrote:
> ima_measure_critical_data() and process_buffer_measurement() currently
> don't return a result. A caller wouldn't be able to know whether those
> functions were executed successfully.

Missing is an explanation as to why these functions aren't currently
returning a result.   The LSM/IMA hooks only return a negative result
for failure to appraise a file's integrity, not measure a file.  Only
failure to appraise a file's integrity results in preventing the file
from being read/executed/mmaped.  Other failures are only audited.

> 
> This patch modifies the return type from void to int, and returns 0 if the
> buffer has been successfully measured, a negative value otherwise.

Needed here is an explanation as to why ima_measure_critical_data() is
special.

> 
> Also, this patch does not modify the behavior of existing callers by
> processing the returned value. For those, the return value is ignored.

I agree that the existing behavior shouldn't change, but will this
result in the bots complaining?

thanks,

Mimi

