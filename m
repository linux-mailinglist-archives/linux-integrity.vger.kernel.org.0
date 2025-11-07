Return-Path: <linux-integrity+bounces-7599-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CFBC3EA89
	for <lists+linux-integrity@lfdr.de>; Fri, 07 Nov 2025 07:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396573A5DE6
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Nov 2025 06:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F370304BB8;
	Fri,  7 Nov 2025 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrvFP0Ho"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D152303CB2;
	Fri,  7 Nov 2025 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498489; cv=none; b=H13pPxysvZFxNjoNV+I5Ao7m8qgbY/TLgzDFTdoHb+B1tYsYaEijCnY6J6c9+0pLc42/jfxeBtWLUrQ9KvbcdCqwAPvRGpsmZHFYom7Lkcmc7uf3DNpejbCrIA4JElpibxpw6SXbCoSaC5FOCtMIe7/+X5Abyc8LgCgsmSeL4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498489; c=relaxed/simple;
	bh=FvfOLjkE80+gbQn+a4An0EOfPXdtb1kZNcilFuT/WU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+NmHYpOnz3F3pHUKZxe3dY+e31XbmpH3cannZ9VGD6EHbwyqSLQfNwmD2Y3afB6KdtqSNbmVpwgmMz22/B1MJS0BK9/aCK74T/vTrRv+YE+PF/en8PWlnFzVU+ZaglApnz+sE06iv7ZWNxJ3R+VNTjRnpLyi899HZvdOapvtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrvFP0Ho; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762498488; x=1794034488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FvfOLjkE80+gbQn+a4An0EOfPXdtb1kZNcilFuT/WU8=;
  b=SrvFP0HoJ2slZ06K8jZ3+D/Yc9FsOJG0dN4gb/wtf6unstFtJ6uwP79i
   SsY7yJCGlduLiW9vj7/Sr2bQa/0ObCm6YCgAw13Rp7h/2KzDS/wOb3bms
   YbFZ6qZ4otIJo7SbbACk89WMumm1+fgMasO5uf67XCNe3FnY5o5cjXUr2
   bX4djGEc2L0gip66EKxL9bJvt93yROU56GopvwSttL8HD6DN9Y+F2QK6j
   qhBd1quDLHp7bZP9R0Y0USXVo1kUbHrdgYU9/12g25QE+ek6C4xiZ0rrQ
   IWIun2y/G8OkhaVNWvDjDyHVdynxeo+Z0JbrpRbHzdB753L4YfqYl9NQ7
   g==;
X-CSE-ConnectionGUID: 2sgf08x/QMCGRvnwSJeuwA==
X-CSE-MsgGUID: gEyI/e7ESeeL6yO+8OcdHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64683787"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="64683787"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 22:54:47 -0800
X-CSE-ConnectionGUID: OdIrGuoIStGBxEkimjt+eg==
X-CSE-MsgGUID: bZw+Z6vgQDyvp9cvISrUzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="225226832"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Nov 2025 22:54:44 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHGMr-000Uoj-1l;
	Fri, 07 Nov 2025 06:54:41 +0000
Date: Fri, 7 Nov 2025 14:54:25 +0800
From: kernel test robot <lkp@intel.com>
To: Tahera Fahimi <taherafahimi@linux.microsoft.com>, zohar@linux.ibm.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	code@tyhicks.com
Cc: oe-kbuild-all@lists.linux.dev,
	Tahera Fahimi <taherafahimi@linux.microsoft.com>
Subject: Re: [Patch V1] ima: avoid duplicate policy rules insertions
Message-ID: <202511071406.hU1UdCKh-lkp@intel.com>
References: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>

Hi Tahera,

kernel test robot noticed the following build warnings:

[auto build test WARNING on zohar-integrity/next-integrity]
[also build test WARNING on linus/master v6.18-rc4 next-20251107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tahera-Fahimi/ima-avoid-duplicate-policy-rules-insertions/20251107-021615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20251106181404.3429710-1-taherafahimi%40linux.microsoft.com
patch subject: [Patch V1] ima: avoid duplicate policy rules insertions
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251107/202511071406.hU1UdCKh-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511071406.hU1UdCKh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511071406.hU1UdCKh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   security/integrity/ima/ima_policy.c: In function 'template_has_field':
>> security/integrity/ima/ima_policy.c:1958:13: warning: unused variable 'j' [-Wunused-variable]
    1958 |         int j;
         |             ^
--
>> Warning: security/integrity/ima/ima_policy.c:2078 function parameter 'new_rule' not described in 'ima_rule_exists'


vim +/j +1958 security/integrity/ima/ima_policy.c

  1955	
  1956	static bool template_has_field(const char *field_id, const struct ima_template_desc *template2)
  1957	{
> 1958		int j;
  1959	
  1960		for (int j = 0; j < template2->num_fields; j++)
  1961			if (strcmp(field_id, template2->fields[j]->field_id) == 0)
  1962				return true;
  1963	
  1964		return false;
  1965	}
  1966	
  1967	static bool keyring_has_item(const char *item, const struct ima_rule_opt_list *keyrings)
  1968	{
  1969		int j;
  1970	
  1971		for (j = 0; j < keyrings->count; j++) {
  1972			if (strcmp(item, keyrings->items[j]) == 0)
  1973				return true;
  1974		}
  1975		return false;
  1976	}
  1977	
  1978	static bool labels_has_item(const char *item, const struct ima_rule_opt_list *labels)
  1979	{
  1980		int j;
  1981	
  1982		for (j = 0; j < labels->count; j++) {
  1983			if (strcmp(item, labels->items[j]) == 0)
  1984				return true;
  1985		}
  1986		return false;
  1987	}
  1988	
  1989	static bool ima_rules_equal(const struct ima_rule_entry *rule1, const struct ima_rule_entry *rule2)
  1990	{
  1991		int i;
  1992	
  1993		if (rule1->flags != rule2->flags)
  1994			return false;
  1995	
  1996		if (rule1->action != rule2->action)
  1997			return false;
  1998	
  1999		if (((rule1->flags & IMA_FUNC) && rule1->func != rule2->func) ||
  2000		    ((rule1->flags & (IMA_MASK | IMA_INMASK)) && rule1->mask != rule2->mask) ||
  2001		    ((rule1->flags & IMA_FSMAGIC) && rule1->fsmagic != rule2->fsmagic) ||
  2002		    ((rule1->flags & IMA_FSUUID) && !uuid_equal(&rule1->fsuuid, &rule2->fsuuid)) ||
  2003		    ((rule1->flags & IMA_UID) && !uid_eq(rule1->uid, rule2->uid)) ||
  2004		    ((rule1->flags & IMA_GID) && !gid_eq(rule1->gid, rule2->gid)) ||
  2005		    ((rule1->flags & IMA_FOWNER) && !uid_eq(rule1->fowner, rule2->fowner)) ||
  2006		    ((rule1->flags & IMA_FGROUP) && !gid_eq(rule1->fgroup, rule2->fgroup)) ||
  2007		    ((rule1->flags & IMA_FSNAME) && (strcmp(rule1->fsname, rule2->fsname) != 0)) ||
  2008		    ((rule1->flags & IMA_PCR) && rule1->pcr != rule2->pcr) ||
  2009		    ((rule1->flags & IMA_VALIDATE_ALGOS) &&
  2010		      rule1->allowed_algos != rule2->allowed_algos) ||
  2011		    ((rule1->flags & IMA_EUID) && !uid_eq(rule1->uid, rule2->uid)) ||
  2012		    ((rule1->flags & IMA_EGID) && !gid_eq(rule1->gid, rule2->gid)))
  2013			return false;
  2014	
  2015		if (!rule1->template && !rule2->template) {
  2016			;
  2017		} else if (!rule1->template || !rule2->template) {
  2018			return false;
  2019		} else if (rule1->template->num_fields != rule2->template->num_fields) {
  2020			return false;
  2021		} else if (rule1->template->num_fields != 0) {
  2022			for (i = 0; i < rule1->template->num_fields; i++) {
  2023				if (!template_has_field(rule1->template->fields[i]->field_id,
  2024							rule2->template))
  2025					return false;
  2026			}
  2027		}
  2028	
  2029		if (rule1->flags & IMA_KEYRINGS) {
  2030			if (!rule1->keyrings && !rule2->keyrings) {
  2031				;
  2032			} else if (!rule1->keyrings || !rule2->keyrings) {
  2033				return false;
  2034			} else if (rule1->keyrings->count != rule2->keyrings->count) {
  2035				return false;
  2036			} else if (rule1->keyrings->count != 0) {
  2037				for (i = 0; i < rule1->keyrings->count; i++) {
  2038					if (!keyring_has_item(rule1->keyrings->items[i], rule2->keyrings))
  2039						return false;
  2040				}
  2041			}
  2042		}
  2043	
  2044		if (rule1->flags & IMA_LABEL) {
  2045			if (!rule1->label && !rule2->label) {
  2046				;
  2047			} else if (!rule1->label || !rule2->label) {
  2048				return false;
  2049			} else if (rule1->label->count != rule2->label->count) {
  2050				return false;
  2051			} else if (rule1->label->count != 0) {
  2052				for (i = 0; i < rule1->label->count; i++) {
  2053					if (!labels_has_item(rule1->label->items[i], rule2->label))
  2054						return false;
  2055				}
  2056			}
  2057		}
  2058	
  2059		for (i = 0; i < MAX_LSM_RULES; i++) {
  2060			if (!rule1->lsm[i].rule && !rule2->lsm[i].rule)
  2061				continue;
  2062	
  2063			if (!rule1->lsm[i].rule || !rule2->lsm[i].rule)
  2064				return false;
  2065	
  2066			if (strcmp(rule1->lsm[i].args_p, rule2->lsm[i].args_p) != 0)
  2067				return false;
  2068		}
  2069	
  2070		return true;
  2071	}
  2072	
  2073	/**
  2074	 * ima_rule_exists - check if a rule already exists in the policy
  2075	 *
  2076	 * Checking both the active policy and the temporary rules list.
  2077	 */
> 2078	static bool ima_rule_exists(struct ima_rule_entry *new_rule)
  2079	{
  2080		struct ima_rule_entry *entry;
  2081		struct list_head *ima_rules_tmp;
  2082	
  2083		if (!list_empty(&ima_temp_rules)) {
  2084			list_for_each_entry(entry, &ima_temp_rules, list) {
  2085				if (ima_rules_equal(entry, new_rule))
  2086					return true;
  2087			}
  2088		}
  2089	
  2090		rcu_read_lock();
  2091		ima_rules_tmp = rcu_dereference(ima_rules);
  2092		list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
  2093			if (ima_rules_equal(entry, new_rule)) {
  2094				rcu_read_unlock();
  2095				return true;
  2096			}
  2097		}
  2098		rcu_read_unlock();
  2099	
  2100		return false;
  2101	}
  2102	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

