Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE74A198378
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgC3Sgx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 14:36:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgC3Sgw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 14:36:52 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UIXaur079419
        for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2020 14:36:51 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 302337k83b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2020 14:36:51 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 30 Mar 2020 19:36:40 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Mar 2020 19:36:38 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02UIakat62652580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 18:36:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 720364C040;
        Mon, 30 Mar 2020 18:36:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDC0A4C044;
        Mon, 30 Mar 2020 18:36:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.180.158])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Mar 2020 18:36:45 +0000 (GMT)
Subject: Re: Immutable metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "matthewgarrett@google.com" <matthewgarrett@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Mon, 30 Mar 2020 14:36:45 -0400
In-Reply-To: <378d0dea0ccb49b8a0f0e58301328b5a@huawei.com>
References: <ff12bbbd945545a988ef84d6e4d3b83d@huawei.com>
         <1585534223.5188.408.camel@linux.ibm.com>
         <1585583203.5188.418.camel@linux.ibm.com>
         <378d0dea0ccb49b8a0f0e58301328b5a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20033018-0008-0000-0000-000003674AD2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033018-0009-0000-0000-00004A88CC84
Message-Id: <1585593405.5188.450.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_07:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011 adultscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300157
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-03-30 at 15:56 +0000, Roberto Sassu wrote:
> > -----Original Message-----
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Monday, March 30, 2020 5:47 PM
> > To: Roberto Sassu <roberto.sassu@huawei.com>;
> > matthewgarrett@google.com
> > Cc: linux-integrity@vger.kernel.org; Silviu Vlasceanu
> > <Silviu.Vlasceanu@huawei.com>
> > Subject: Re: Immutable metadata
> > 
> > On Sun, 2020-03-29 at 22:10 -0400, Mimi Zohar wrote:
> > > Hi Roberto,
> > >
> > > On Sat, 2020-03-28 at 11:18 +0000, Roberto Sassu wrote:
> > > > Hi Matthew, Mimi
> > > >
> > > > I have a question about portable signatures. Is there any particular
> > reason
> > > > why a write to a file is not denied by IMA if metadata are immutable?
> > >
> > > As much as possible, IMA and EVM should be independent of each other.
> > >  EVM is responsible for the integrity of file metadata, so it needs to
> > > read other security xattrs, but IMA shouldn't be looking at the EVM
> > > xattr.
> > >
> > > Like any other security xattr, responsibility for maintaining the
> > > xattr is left up to the particular LSM.  In this case, EVM would need
> > > to prevent the file from being opened rw.  Should that be hard coded
> > > or based on an EVM policy?
> > 
> > Thinking about this a bit more, evm_verifyxattr() is already returning
> > INTEGRITY_PASS_IMMUTABLE.  I guess IMA could make decisions based on
> > it.
> 
> Yes, this was the idea.
> 
> I would say also that files with portable signatures fulfill the appraise_type=imasig
> requirement. I would set the IMA_DIGSIG bit in iint->atomic_flags. Is it ok?

Ok, so locking doesn't seem to be an issue here.  I'm not sure about
re-using the existing bit.  EVM_XATTR_PORTABLE_DIGSIG is dependent on
the existence of a file hash.  The existing bit prevents calculating
and writing the file hash as an xattr.  Would this affect installing
new files?

Mimi

