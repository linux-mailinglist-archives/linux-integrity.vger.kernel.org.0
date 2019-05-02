Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D19A11F7F
	for <lists+linux-integrity@lfdr.de>; Thu,  2 May 2019 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfEBPsp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 May 2019 11:48:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbfEBPsm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 May 2019 11:48:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42FmD0x128936
        for <linux-integrity@vger.kernel.org>; Thu, 2 May 2019 11:48:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s81chpkbg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 May 2019 11:48:41 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 2 May 2019 16:48:38 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 16:48:34 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42FmX7O47448276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 15:48:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EC26A404D;
        Thu,  2 May 2019 15:48:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E117A4051;
        Thu,  2 May 2019 15:48:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.175])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 15:48:31 +0000 (GMT)
Subject: Re: [PATCH] kexec_buffer measure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     prakhar srivastava <prsriva02@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Date:   Thu, 02 May 2019 11:48:21 -0400
In-Reply-To: <1555978681.4914.305.camel@linux.ibm.com>
References: <CAEFn8qKkXgxUKtribbtFwvG9NykGQo10jQ5Du_i9wJz-wKreOA@mail.gmail.com>
         <1555978681.4914.305.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050215-0012-0000-0000-000003179DCD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050215-0013-0000-0000-000021500DB5
Message-Id: <1556812101.4134.28.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=993 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020105
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Paul, John, Casey]

On Mon, 2019-04-22 at 20:18 -0400, Mimi Zohar wrote:
> [Cc'ing LSM mailing list]
> 
> On Fri, 2019-04-19 at 17:30 -0700, prakhar srivastava wrote:
> 
> > 2) Adding a LSM hook
> > We are doing both the command line and kernel version measurement in IMA.
> > Can you please elaborate on how this can be used outside of the scenario?
> > That will help me come back with a better design and code. I am
> > neutral about this.
> 
> As I said previously, initially you might want to only measure the
> kexec boot command line, but will you ever want to verify or audit log
> the boot command line hash?  Perhaps LSMs would be interested in the
> boot command line.  Should this be an LSM hook?

From an LSM perspective, is there any interest in the boot command line?

Mimi

