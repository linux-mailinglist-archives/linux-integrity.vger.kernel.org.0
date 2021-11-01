Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FAA441A78
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Nov 2021 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhKALO1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Nov 2021 07:14:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231485AbhKALO1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Nov 2021 07:14:27 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A19qAOt009654;
        Mon, 1 Nov 2021 11:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=qpzpNeMM353jv+aIU5E5LwGs8Fmfs9hCdTzRofg0u5U=;
 b=JeH1OKAQ2NpRQ3Tvcqz4wZCHE9qKGXZQ7Xod+6+DtMA7S7FayOAn/Y4xCQucK+yD9RK6
 w5kggxwjlsLNbjs3Ek7zbRi3WJLyy9ZoAVZsZOIRGfnsbrZJXd3B2m6/k5rsbeJA3lwO
 td2oAyDPKhrWWt0JD7qODInNPLQkKU2oA+XRZBpxIFprhjXMEAkoV9NGvGwtKMt968PF
 NgUuNaGqnbRdhLAZJXhx8FpMnXj2m7Yh5TF8Q4BLnJURe7P5fT+uRaLMcSahpFzcOS27
 eS6shtA3NPeUa4NMp9k+FIqvaqF0Rr/ZaYF+nWExwCqiB/en93kEc+ALoLfYE2gbGpPx pw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c2e01sac5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Nov 2021 11:11:52 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A1B8ZlX020575;
        Mon, 1 Nov 2021 11:11:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3c0wp9h5hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Nov 2021 11:11:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A1B5Qnw62980468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Nov 2021 11:05:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 341DC11C054;
        Mon,  1 Nov 2021 11:11:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A27D11C052;
        Mon,  1 Nov 2021 11:11:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.124.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Nov 2021 11:11:46 +0000 (GMT)
Message-ID: <dc8614682d047a3adb1135c626203b4fc21059f4.camel@linux.ibm.com>
Subject: Re: IMA testsuite?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Mon, 01 Nov 2021 07:11:46 -0400
In-Reply-To: <c8012c58-6cce-1d17-902e-a9e757c39822@schaufler-ca.com>
References: <c8012c58-6cce-1d17-902e-a9e757c39822.ref@schaufler-ca.com>
         <c8012c58-6cce-1d17-902e-a9e757c39822@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UPjmRP43J1x24azAWGKxBopPon2TCX4b
X-Proofpoint-ORIG-GUID: UPjmRP43J1x24azAWGKxBopPon2TCX4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_04,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxlogscore=852 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111010064
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-10-29 at 17:19 -0700, Casey Schaufler wrote:
> I'm having trouble tracking down an official IMA testsuite.
> Is there one?

There are tests in LTP, kselftests, eBPF, and ima-evm-utils, but not
per-se a single full testsuite.

Mimi

