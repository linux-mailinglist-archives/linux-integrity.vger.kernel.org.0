Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1128019801C
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgC3Pqu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 11:46:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728594AbgC3Pqu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 11:46:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UFXDO9119514
        for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2020 11:46:49 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30206x9kmc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2020 11:46:49 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 30 Mar 2020 16:46:41 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Mar 2020 16:46:39 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02UFki3j45613374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 15:46:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51D0A52051;
        Mon, 30 Mar 2020 15:46:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.180.158])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B6D7D52054;
        Mon, 30 Mar 2020 15:46:43 +0000 (GMT)
Subject: Re: Immutable metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "matthewgarrett@google.com" <matthewgarrett@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Mon, 30 Mar 2020 11:46:43 -0400
In-Reply-To: <1585534223.5188.408.camel@linux.ibm.com>
References: <ff12bbbd945545a988ef84d6e4d3b83d@huawei.com>
         <1585534223.5188.408.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20033015-0012-0000-0000-0000039B07AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033015-0013-0000-0000-000021D81037
Message-Id: <1585583203.5188.418.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_06:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-03-29 at 22:10 -0400, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Sat, 2020-03-28 at 11:18 +0000, Roberto Sassu wrote:
> > Hi Matthew, Mimi
> > 
> > I have a question about portable signatures. Is there any particular reason
> > why a write to a file is not denied by IMA if metadata are immutable?
> 
> As much as possible, IMA and EVM should be independent of each other.
>  EVM is responsible for the integrity of file metadata, so it needs to
> read other security xattrs, but IMA shouldn't be looking at the EVM
> xattr.
> 
> Like any other security xattr, responsibility for maintaining the
> xattr is left up to the particular LSM.  In this case, EVM would need
> to prevent the file from being opened rw.  Should that be hard coded
> or based on an EVM policy?

Thinking about this a bit more, evm_verifyxattr() is already returning
INTEGRITY_PASS_IMMUTABLE.  I guess IMA could make decisions based on
it.

Mimi

