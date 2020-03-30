Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D40619724E
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 04:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgC3CKc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 29 Mar 2020 22:10:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728107AbgC3CKc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 Mar 2020 22:10:32 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02U24IWb005272
        for <linux-integrity@vger.kernel.org>; Sun, 29 Mar 2020 22:10:31 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 301yfe60c6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 29 Mar 2020 22:10:31 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 30 Mar 2020 03:10:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Mar 2020 03:10:14 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02U2APcH60817544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 02:10:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 489D9A4055;
        Mon, 30 Mar 2020 02:10:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 544B1A4040;
        Mon, 30 Mar 2020 02:10:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.197.133])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Mar 2020 02:10:24 +0000 (GMT)
Subject: Re: Immutable metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "matthewgarrett@google.com" <matthewgarrett@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Sun, 29 Mar 2020 22:10:23 -0400
In-Reply-To: <ff12bbbd945545a988ef84d6e4d3b83d@huawei.com>
References: <ff12bbbd945545a988ef84d6e4d3b83d@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20033002-0020-0000-0000-000003BDF231
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033002-0021-0000-0000-000022168B05
Message-Id: <1585534223.5188.408.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-29_10:2020-03-27,2020-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=871 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300013
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Sat, 2020-03-28 at 11:18 +0000, Roberto Sassu wrote:
> Hi Matthew, Mimi
> 
> I have a question about portable signatures. Is there any particular reason
> why a write to a file is not denied by IMA if metadata are immutable?

As much as possible, IMA and EVM should be independent of each other.
 EVM is responsible for the integrity of file metadata, so it needs to
read other security xattrs, but IMA shouldn't be looking at the EVM
xattr.

Like any other security xattr, responsibility for maintaining the
xattr is left up to the particular LSM.  In this case, EVM would need
to prevent the file from being opened rw.  Should that be hard coded
or based on an EVM policy?

Mimi



