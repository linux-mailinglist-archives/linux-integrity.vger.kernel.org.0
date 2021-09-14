Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA8A40B2F9
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhINP0O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 11:26:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231816AbhINP0N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 11:26:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EDtmoe007011;
        Tue, 14 Sep 2021 11:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rgTv3m0mHeTAp750Kxn8SsDfSu1NAz22BjY6WJXRZrM=;
 b=jCZfJcsfJ0Cn3wxtZAxgiSJZ87+vr+nGWEe4j+CgYBQWtx/q95/5z+6EHbfF8HfLep0s
 NIzH6ZoZgR6vZ2xNgbDKhJTaWzLBTGpvU8N2cKvlYDf++ofCSm/X2z1OgmY0+URg/eHt
 N1qRKv/hoAGuf8VR3lvHERpozWy1eDTnk1qLcvyTAON5LkbMxUfqLwAamOGoUQszE50s
 bUT2tQ0moDxfS5OYS4CpM+nQBQtbZKNMBxRZ+fvt8SQmVWSHFaKlLv8V7rFlDhUI/56V
 STrb+Nba/DRe4PQH5GtR7kP2YPEpusXqr1V7MkH3GgjOCagAMTfIegUB1Sa9v+L/+OSc lg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b2ubrdy4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 11:24:54 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18EF3SO9011898;
        Tue, 14 Sep 2021 15:24:52 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3b0kqjnqjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 15:24:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18EFOnrq55837126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 15:24:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02BE1AE061;
        Tue, 14 Sep 2021 15:24:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53DA4AE04D;
        Tue, 14 Sep 2021 15:24:48 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.116.105])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Sep 2021 15:24:48 +0000 (GMT)
Message-ID: <6414e00be446a806787a8496057cab6fbdf26cde.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/9] ima-evm-utils: Add support for signing with
 pkcs11 URIs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Date:   Tue, 14 Sep 2021 11:24:47 -0400
In-Reply-To: <20210913221813.2554880-1-stefanb@linux.ibm.com>
References: <20210913221813.2554880-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sv9tyJmvj1afCxvOomUdSfXQLRGM_rkg
X-Proofpoint-ORIG-GUID: Sv9tyJmvj1afCxvOomUdSfXQLRGM_rkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140068
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-09-13 at 18:18 -0400, Stefan Berger wrote:
> This series of patches adds support for signing with pkcs11 URIs so that
> pkcs11-enabled devices can also be used for file signing.
> 
> Extend the existing sign_verify.test with tests for the new pkcs11 URI support. 
> Use SoftHSM, when available, as a pkcs11 device for testing.

Thanks, Stefan.  This patch set is now queued in the next-testing
branch.

Mimi

