Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1637A8A2
	for <lists+linux-integrity@lfdr.de>; Tue, 11 May 2021 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhEKONO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 10:13:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57176 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231305AbhEKONN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 10:13:13 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BE3FlI018223;
        Tue, 11 May 2021 10:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Rd9kBmCBoHoD21lvLz9FYE3OvjHLwEsadf0ipH0W7LQ=;
 b=FiDl4r22AXRRofJp+oVCTl6CkpWfggE7JtDxW87mtLw8oAae52QpAfG1fZMnWdqWLrGj
 0ZB6ySYN1qmJ9nXetXwrTNvoVEPRrw3dz/HN8XnnVS5veDk9AGkaE5FMMLLbAvROdcvs
 vBbwaf1kGIYxIqneo0d85Vgkcg07jR28A/Fgj05746CJEIxnu5ZJ8Gwk5lHhMYOk8SgE
 qw4lWORF+ynBUQtZ4dAXjohsVyR5mbvH1wGXTnYgspDQ2oWeHPmWrWNBBYFv6rRdl7Vm
 nRNaL3B3J0RAFt52GIjmXCOM9+aMpYFmhJALNiz65nndsaZ0LltcpjrfWkPMqx5q0nRZ nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38frm9dxb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 10:11:58 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14BE3UDa019864;
        Tue, 11 May 2021 10:11:57 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38frm9dxa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 10:11:57 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BDw27e012704;
        Tue, 11 May 2021 14:11:55 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 38ef37gqp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 14:11:55 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BEBr3i19202412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 14:11:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F8CA11C058;
        Tue, 11 May 2021 14:11:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D9D611C064;
        Tue, 11 May 2021 14:11:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.116.76])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 May 2021 14:11:50 +0000 (GMT)
Message-ID: <735bae46f0772b40ef6ecfb3c6fe0267b3ebbee8.camel@linux.ibm.com>
Subject: Re: [PATCH v6 08/11] evm: Allow setxattr() and setattr() for
 unmodified metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        kernel test robot <lkp@intel.com>
Date:   Tue, 11 May 2021 10:11:49 -0400
In-Reply-To: <20210505113329.1410943-4-roberto.sassu@huawei.com>
References: <20210505112935.1410679-1-roberto.sassu@huawei.com>
         <20210505113329.1410943-4-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2gHa9IKMeQPDBAZQELyLLsM0tVznr4kK
X-Proofpoint-ORIG-GUID: VQjWT_i38fDwTtr2tpp3kYIfBtfrhWJL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=892 phishscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110108
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Wed, 2021-05-05 at 13:33 +0200, Roberto Sassu wrote:
> With the patch to allow xattr/attr operations if a portable signature
> verification fails, cp and tar can copy all xattrs/attrs so that at the
> end of the process verification succeeds.
> 
> However, it might happen that the xattrs/attrs are already set to the
> correct value (taken at signing time) and signature verification succeeds
> before the copy has completed. For example, an archive might contains files
> owned by root and the archive is extracted by root.
> 
> Then, since portable signatures are immutable, all subsequent operations
> fail (e.g. fchown()), even if the operation is legitimate (does not alter
> the current value).
> 
> This patch avoids this problem by reporting successful operation to user
> space when that operation does not alter the current value of xattrs/attrs.

I must be missing something.  If both the IMA and EVM status flags are
reset after xattr or attr modification, do we really need to prevent
any metadata - same or different - changes?  Both evm_protect_xattr()
and evm_inode_setattr() would need to be modified to allow
INTEGRITY_PASS_IMMUTABLE.

thanks,

Mimi

