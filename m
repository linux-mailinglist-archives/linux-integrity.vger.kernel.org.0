Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63859820D3
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2019 17:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfHEPyc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Aug 2019 11:54:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729152AbfHEPyb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Aug 2019 11:54:31 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75FlDJI142675
        for <linux-integrity@vger.kernel.org>; Mon, 5 Aug 2019 11:54:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u6mn81p42-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Aug 2019 11:54:30 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 5 Aug 2019 16:54:26 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Aug 2019 16:54:21 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x75FsLlx59637940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Aug 2019 15:54:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A1B9AE051;
        Mon,  5 Aug 2019 15:54:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA8C7AE04D;
        Mon,  5 Aug 2019 15:54:19 +0000 (GMT)
Received: from dhcp-9-31-103-47.watson.ibm.com (unknown [9.31.103.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Aug 2019 15:54:19 +0000 (GMT)
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     jejb@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Date:   Mon, 05 Aug 2019 11:54:19 -0400
In-Reply-To: <e10f7b04-3d63-435e-180e-72a084ac4bab@huawei.com>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
         <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
         <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
         <20190801163215.mfkagoafkxscesne@linux.intel.com>
         <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
         <20190802142721.GA26616@elm>
         <20190802194226.oiztvme5klkmw6fh@linux.intel.com>
         <20190802202343.GE26616@elm>
         <e10f7b04-3d63-435e-180e-72a084ac4bab@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19080515-0020-0000-0000-0000035B3673
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080515-0021-0000-0000-000021AF51D8
Message-Id: <1565020459.11223.179.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050175
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-08-05 at 16:50 +0200, Roberto Sassu wrote:
> Regarding Mimi's proposal to avoid the issue by extending the PCR with
> zeros, I think it also achieve the goal. 

Roberto, removing the following code from init_digests() would be the
equivalent to the prior code, without needing to make any other
changes.  Let's keep it simple.  Do you want to post the patch with
the change, or should I?

        ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
        if (ret < 0)
                return ret;
        if (ret < TPM_MAX_DIGEST_SIZE)
                return -EFAULT;

As I can't duplicate the problem, it would need to be tested by others
experiencing the problem.

thanks,

Mimi

