Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968184071A3
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Sep 2021 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhIJTFV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Sep 2021 15:05:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233156AbhIJTFS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Sep 2021 15:05:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AJ3Lc1037375;
        Fri, 10 Sep 2021 15:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pC4LNIF/AAe4jqIs+XGaKPKIB4/VU839zIaRoxq/9qs=;
 b=lhcHukavigwnTTZtYJ8hKttqav6LjR7B+OfSfgH27ql0Q3AlMzaGVEGmQm3BVHvPtSa1
 om8nFcVv0ErU5PxIyR5CQwa9xE95zsWbkmJykTsAOAfQodmcMk1UAtodbQVuhY1XUyGr
 ZVz50VSJITziD72sad1+bw7zBJMty2PW+onijr+uNCTqvcnXOEJQp2wkMhnrofEd6iSj
 hopV+AyJO481StKExZRQNlLrLgedjOmpNZo81DfyW5CTfzRnH/JN6EejYWZvQxSdz03g
 HEKZ0AMypqtLJLl/NvdxqYRepjELGoFAKQdO+vmYmllLUfxff6RSyWPVj9qIPYCgZxD8 AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b05nq230n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Sep 2021 15:04:03 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18AJ3M7a037384;
        Fri, 10 Sep 2021 15:04:03 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b05nq2307-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Sep 2021 15:04:03 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18AJ2Oil018816;
        Fri, 10 Sep 2021 19:04:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3axcnkjur4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Sep 2021 19:04:00 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18AIxZ8n55837142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 18:59:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0327011C054;
        Fri, 10 Sep 2021 19:03:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C86811C050;
        Fri, 10 Sep 2021 19:03:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.55.253])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Sep 2021 19:03:56 +0000 (GMT)
Message-ID: <49378953e411e8e93f6f4503de7f6a2ec9d8e961.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4] evmctl: Use secure heap for private
 keys and passwords
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Bruno Meneguele <bmeneg@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 10 Sep 2021 15:03:55 -0400
In-Reply-To: <413f31067da8a63ecd76228e86505a9f4e5599f8.camel@linux.ibm.com>
References: <20210904105054.3388329-1-vt@altlinux.org>
         <413f31067da8a63ecd76228e86505a9f4e5599f8.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KuASyEehqG7htBaBIwwHMbs1bYno7aKP
X-Proofpoint-GUID: EYqdH-qpSnSkdcS3KY-O7Xcq_bhSSkxv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly, Stefan,

On Fri, 2021-09-10 at 10:55 -0400, Mimi Zohar wrote:
> What was the conclusion in terms of reading the password stored in the
> environment variable?

If this is an issue, perhaps call the equivalent of optarg_password()
to store the environment variable in secure heap memory.

Something like:
	imaevm_params.keypass =
optarg_password(getenv("EVMCTL_KEY_PASSWORD"));

optarg_password() would then become a wrapper around the new function.

thanks,

Mimi

